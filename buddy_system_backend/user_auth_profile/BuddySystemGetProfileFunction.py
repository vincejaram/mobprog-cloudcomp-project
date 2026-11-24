import json
import boto3

def lambda_handler(event, context):
    dynamodb = boto3.resource("dynamodb")
    table = dynamodb.Table("buddy_system_users")

    headers = {
        "Access-Control-Allow-Headers": "Content-Type",
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "OPTIONS,GET",
    }

    params = event.get("queryStringParameters") or {}
    user_uuid = params.get("uuid")

    if not user_uuid:
        return {
            "statusCode": 400,
            "headers": headers,
            "body": json.dumps({"message": "Missing 'uuid' in query parameters"}),
        }

    try:
        response = table.get_item(Key={"uuid": user_uuid})
        item = response.get("Item")

        if not item:
            return {
                "statusCode": 404,
                "headers": headers,
                "body": json.dumps({"message": "User not found"}),
            }

        item.pop("password", None)

        return {
            "statusCode": 200,
            "headers": headers,
            "body": json.dumps({"message": "Profile retrieved", "data": item}),
        }

    except Exception as e:
        return {
            "statusCode": 500,
            "headers": headers,
            "body": json.dumps({"message": str(e)}),
        }
