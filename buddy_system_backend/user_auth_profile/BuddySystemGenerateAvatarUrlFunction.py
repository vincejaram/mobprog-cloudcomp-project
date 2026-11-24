import json
import boto3

def lambda_handler(event, context):
    s3_client = boto3.client("s3")
    bucket_name = "buddysystem-media-bucket"

    headers = {
        "Access-Control-Allow-Headers": "Content-Type",
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "OPTIONS,POST",
    }

    try:
        body = json.loads(event.get("body", "{}"))
        user_uuid = body.get("uuid")
        content_type = body.get("contentType", "image/jpeg")

        if not user_uuid:
            return {
                "statusCode": 400,
                "headers": headers,
                "body": json.dumps({"message": "Missing required field: uuid"}),
            }

        file_key = f"avatars/{user_uuid}.jpg"

        upload_url = s3_client.generate_presigned_url(
            "put_object",
            Params={
                "Bucket": bucket_name,
                "Key": file_key,
                "ContentType": content_type,
            },
            ExpiresIn=300,
        )

        public_url = f"https://{bucket_name}.s3.amazonaws.com/{file_key}"

        return {
            "statusCode": 200,
            "headers": headers,
            "body": json.dumps({
                "message": "Pre-signed URL generated",
                "uploadUrl": upload_url,
                "profilePicUrl": public_url,
            }),
        }

    except Exception as e:
        return {
            "statusCode": 500,
            "headers": headers,
            "body": json.dumps({"message": str(e)}),
        }
