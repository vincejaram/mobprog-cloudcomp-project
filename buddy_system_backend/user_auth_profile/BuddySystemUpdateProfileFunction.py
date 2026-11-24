import json
import boto3

def lambda_handler(event, context):
    dynamodb = boto3.resource("dynamodb")
    table = dynamodb.Table("buddy_system_users")

    headers = {
        "Access-Control-Allow-Headers": "Content-Type",
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "OPTIONS,POST,PUT",
    }

    try:
        body = json.loads(event.get("body", "{}"))
        user_uuid = body.get("uuid")

        if not user_uuid:
            return {
                "statusCode": 400,
                "headers": headers,
                "body": json.dumps({"message": "Missing required field: uuid"}),
            }

        allowed_fields = ["username", "firstName", "lastName", "bio", "profilePicUrl"]
        update_expr = []
        expr_names = {}
        expr_values = {}

        for field in allowed_fields:
            if field in body:
                update_expr.append(f"#{field} = :{field}")
                expr_names[f"#{field}"] = field
                expr_values[f":{field}"] = body[field]

        if not update_expr:
            return {
                "statusCode": 400,
                "headers": headers,
                "body": json.dumps({"message": "No valid profile fields provided to update"}),
            }

        response = table.update_item(
            Key={"uuid": user_uuid},
            UpdateExpression="SET " + ", ".join(update_expr),
            ExpressionAttributeNames=expr_names,
            ExpressionAttributeValues=expr_values,
            ReturnValues="ALL_NEW",
        )

        updated_user = response.get("Attributes", {})
        updated_user.pop("password", None)

        return {
            "statusCode": 200,
            "headers": headers,
            "body": json.dumps({"message": "Profile updated successfully", "data": updated_user}),
        }

    except Exception as e:
        return {
            "statusCode": 500,
            "headers": headers,
            "body": json.dumps({"message": str(e)}),
        }
