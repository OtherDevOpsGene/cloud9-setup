'''
Reads the usernames from an AWS DynamoDB table and returns them as a JSON
encoded array for use as a Terraform external data source.

$ python3 get_usernames.py | jq
{
  "usernames": "[\"jerry\", \"tom\"]"
}
'''

import boto3  
import json
import os

# Load environment variables with defaults
DYNAMODB_TABLE = os.getenv('DYNAMODB_TABLE', 'usernames')
AWS_REGION = os.getenv('AWS_REGION', 'us-east-2')

def get_all_usernames(table_name=DYNAMODB_TABLE, region=AWS_REGION):
    # Initialize DynamoDB client
    dynamodb = boto3.resource('dynamodb', region_name=region)
    table = dynamodb.Table(DYNAMODB_TABLE)  # Replace with your table name

    usernames = []
    last_evaluated_key = None

    try:
        # Paginate through all records
        while True:
            if last_evaluated_key:
                response = table.scan(
                    ExclusiveStartKey=last_evaluated_key
                )
            else:
                response = table.scan()

            # Extract usernames from response
            for item in response['Items']:
                if 'username' in item:
                    usernames.append(item['username'])

            # Check if there are more items to fetch
            last_evaluated_key = response.get('LastEvaluatedKey')
            if not last_evaluated_key:
                break

        # Return JSON encoded array of usernames
        return json.dumps(usernames)

    except Exception as e:
        print(f"Error reading from DynamoDB: {str(e)}")
        return json.dumps([])

if __name__ == "__main__":
    result = get_all_usernames()
    json_result = json.dumps({"usernames": result})
    
    print(json_result)
    