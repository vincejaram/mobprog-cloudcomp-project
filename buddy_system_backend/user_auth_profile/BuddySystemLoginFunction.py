import json
import boto3
from boto3.dynamodb.conditions import Attr

def lambda_handler(event, context):
    dynamodb = boto3.resource("dynamodb")
    table = dynamodb.Table("buddy_system_users")

    headers = {
        "Access-Control-Allow-Headers": "Content-Type",
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "OPTIONS,POST,GET",
    }

    params = event.get("queryStringParameters") or {}
    username = params.get("username")
    password = params.get("password")

    if not username or not password:
        return {
            "statusCode": 400,
            "headers": headers,
            "body": json.dumps({"message": "Missing 'username' or 'password' in query parameters"}),
        }

    try:
        response = table.scan(
            FilterExpression=Attr("username").eq(username) & Attr("password").eq(password)
        )

        items = response.get("Items", [])

        if items:
            return {
                "statusCode": 200,
                "headers": headers,
                "body": json.dumps({"message": "User found", "data": items[0]}),
            }
        else:
            return {
                "statusCode": 404,
                "headers": headers,
                "body": json.dumps({"message": "Invalid username or password"}),
            }

    except Exception as e:
        return {
            "statusCode": 500,
            "headers": headers,
            "body": json.dumps({"message": str(e)}),
        }
