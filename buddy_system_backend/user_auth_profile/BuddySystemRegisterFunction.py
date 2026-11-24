import json
import uuid
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

    try:
        body = json.loads(event.get("body", "{}"))

        required_fields = [
            "username",
            "email",
            "password",
            "createdDate",
            "firstName",
            "lastName",
        ]
        for field in required_fields:
            if field not in body or not body[field]:
                return {
                    "statusCode": 400,
                    "headers": headers,
                    "body": json.dumps({"message": f"Missing required field: {field}"}),
                }

        username = body["username"]
        email = body["email"]

        existing_user = table.scan(
            FilterExpression=Attr("username").eq(username) | Attr("email").eq(email),
            ProjectionExpression="#u",
            ExpressionAttributeNames={"#u": "uuid"},
        )

        if existing_user["Count"] > 0:
            return {
                "statusCode": 400,
                "headers": headers,
                "body": json.dumps({"message": "Username or email already exists"}),
            }

        if body.get("uuid") in [None, "", "0"]:
            body["uuid"] = str(uuid.uuid4())

        body.setdefault("bio", "")
        body.setdefault("profilePicUrl", "")

        table.put_item(Item=body)

        return {
            "statusCode": 200,
            "headers": headers,
            "body": json.dumps({"message": f"User {username} added successfully", "data": body}),
        }

    except Exception as e:
        return {
            "statusCode": 500,
            "headers": headers,
            "body": json.dumps({"message": str(e)}),
        }
