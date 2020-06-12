λ aws --endpoint-url=http://192.168.99.100:4574 lambda create-function --region us-east-1 --function-name lambda_find --runtime python3.8 --handler lambda_function_find.lambda_handler --memory-size 128 --zip-file fileb://./api_find.zip --role arn:aws:iam::123456:role/UsersManageOwnCredentials
{
    "FunctionName": "lambda_find",
    "FunctionArn": "arn:aws:lambda:us-east-1:000000000000:function:lambda_find",
    "Runtime": "python3.8",
    "Role": "arn:aws:iam::123456:role/UsersManageOwnCredentials",
    "Handler": "lambda_function_find.lambda_handler",
    "CodeSize": 284,
    "Description": "",
    "Timeout": 3,
    "MemorySize": 128,
    "LastModified": "2020-06-09T02:45:35.896+0000",
    "CodeSha256": "AtEbTkNRtVHAhyGDT1L9KO5epVWQNP/RygdfeezqlaE=",
    "Version": "$LATEST",
    "VpcConfig": {},
    "TracingConfig": {
        "Mode": "PassThrough"
    },
    "RevisionId": "1523b81c-3625-4da8-bd78-93215d37000f",
    "State": "Active",
    "LastUpdateStatus": "Successful"
}

λ aws --endpoint-url=http://192.168.99.100:4574 lambda create-function --region us-east-1 --function-name lambda_create --runtime python3.8 --handler app/lambda_function_create.lambda_handler --memory-size 128 --zip-file fileb://./api_create.zip --role arn:aws:iam::123456:role/UsersManageOwnCredentials
{
    "FunctionName": "lambda_create",
    "FunctionArn": "arn:aws:lambda:us-east-1:000000000000:function:lambda_create",
    "Runtime": "python3.8",
    "Role": "arn:aws:iam::123456:role/UsersManageOwnCredentials",
    "Handler": "app/lambda_function_create.lambda_handler",
    "CodeSize": 295,
    "Description": "",
    "Timeout": 3,
    "MemorySize": 128,
    "LastModified": "2020-06-09T02:40:43.202+0000",
    "CodeSha256": "P76/ns8xHtDXkUbWvO/ACaQDLMd+JIOzWH17Q0z5K4I=",
    "Version": "$LATEST",
    "VpcConfig": {},
    "TracingConfig": {
        "Mode": "PassThrough"
    },
    "RevisionId": "145695fc-a376-4928-acf4-1a43df2bd86f",
    "State": "Active",
    "LastUpdateStatus": "Successful"
}

λ aws --endpoint-url=http://192.168.99.100:4574 lambda create-function --region us-east-1 --function-name lambda_update --runtime python3.8 --handler lambda_function_update.lambda_handler --memory-size 128 --zip-file fileb://./api_update.zip --role arn:aws:iam::123456:role/UsersManageOwnCredentials
{
    "FunctionName": "lambda_update",
    "FunctionArn": "arn:aws:lambda:us-east-1:000000000000:function:lambda_update",
    "Runtime": "python3.8",
    "Role": "arn:aws:iam::123456:role/UsersManageOwnCredentials",
    "Handler": "lambda_function_update.lambda_handler",
    "CodeSize": 288,
    "Description": "",
    "Timeout": 3,
    "MemorySize": 128,
    "LastModified": "2020-06-09T02:42:33.213+0000",
    "CodeSha256": "s4F1bBXfJawdwpNJyHYQoNP5Ls3qccR1SmIgVjxHZOI=",
    "Version": "$LATEST",
    "VpcConfig": {},
    "TracingConfig": {
        "Mode": "PassThrough"
    },
    "RevisionId": "4fb0524a-9d70-4315-bebe-a404a5a1bf78",
    "State": "Active",
    "LastUpdateStatus": "Successful"
}

λ aws --endpoint-url=http://192.168.99.100:4567 apigateway create-rest-api --region us-east-1 --name 'API'
{
    "id": "453wplpxbd",
    "name": "'API'",
    "createdDate": "2020-06-08T23:47:56-03:00",
    "apiKeySource": "HEADER",
    "endpointConfiguration": {
        "types": [
            "EDGE"
        ]
    },
    "tags": {}
}

λ aws --endpoint-url=http://192.168.99.100:4567  apigateway get-resources --region us-east-1 --rest-api-id 453wplpxbd
{
    "items": [
        {
            "id": "dm3z7gkjf5",
            "path": "/"
        }
    ]
}

λ aws --endpoint-url=http://192.168.99.100:4567 apigateway create-resource --region us-east-1 --rest-api-id 453wplpxbd --parent-id dm3z7gkjf5 --path-part "produto"
{
    "id": "q49w17afey",
    "parentId": "dm3z7gkjf5",
    "pathPart": "{produto}",
    "path": "/{produto}"
}

λ aws --endpoint-url=http://192.168.99.100:4567  apigateway put-method --region us-east-1 --rest-api-id 453wplpxbd --resource-id q49w17afey --http-method GET --request-parameters "method.request.path.somethingId=true" --authorization-type "NONE"
{
    "httpMethod": "GET",
    "authorizationType": "NONE",
    "apiKeyRequired": false
}

λ aws --endpoint-url=http://192.168.99.100:4567  apigateway put-method --region us-east-1 --rest-api-id 453wplpxbd --resource-id q49w17afey --http-method POST --request-parameters "method.request.path.somethingId=true" --authorization-type "NONE"
{
    "httpMethod": "POST",
    "authorizationType": "NONE",
    "apiKeyRequired": false
}

λ aws --endpoint-url=http://192.168.99.100:4567  apigateway put-method --region us-east-1 --rest-api-id 453wplpxbd --resource-id q49w17afey --http-method PUT --request-parameters "method.request.path.somethingId=true" --authorization-type "NONE"
{
    "httpMethod": "PUT",
    "authorizationType": "NONE",
    "apiKeyRequired": false
}

aws --endpoint-url=http://192.168.99.100:4567 apigateway put-integration --region us-east-1 --rest-api-id 453wplpxbd --resource-id q49w17afey --http-method GET --type AWS_PROXY --integration-http-method POST --uri arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:000000000000:function:lambda_find/invocations --passthrough-behavior WHEN_NO_MATCH
{
    "type": "AWS_PROXY",
    "httpMethod": "POST",
    "uri": "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:000000000000:function:lambda_find/invocations",
    "passthroughBehavior": "WHEN_NO_MATCH",
    "cacheNamespace": "26cc90a8",
    "cacheKeyParameters": [],
    "integrationResponses": {
        "200": {
            "statusCode": 200,
            "responseTemplates": {
                "application/json": null
            }
        }
    }
}

aws --endpoint-url=http://192.168.99.100:4567 apigateway put-integration --region us-east-1 --rest-api-id 453wplpxbd --resource-id q49w17afey --http-method POST --type AWS_PROXY --integration-http-method POST --uri arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:000000000000:function:lambda_create/invocations --passthrough-behavior WHEN_NO_MATCH
{
    "type": "AWS_PROXY",
    "httpMethod": "POST",
    "uri": "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:000000000000:function:lambda_create/invocations",
    "passthroughBehavior": "WHEN_NO_MATCH",
    "cacheNamespace": "f0e3e814",
    "cacheKeyParameters": [],
    "integrationResponses": {
        "200": {
            "statusCode": 200,
            "responseTemplates": {
                "application/json": null
            }
        }
    }
}

λ aws --endpoint-url=http://192.168.99.100:4567 apigateway put-integration --region us-east-1 --rest-api-id 453wplpxbd --resource-id q49w17afey --http-method PUT --type AWS_PROXY --integration-http-method POST --uri arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:000000000000:function:lambda_update/invocations --passthrough-behavior WHEN_NO_MATCH
{
    "type": "AWS_PROXY",
    "httpMethod": "POST",
    "uri": "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:000000000000:function:lambda_update/invocations",
    "passthroughBehavior": "WHEN_NO_MATCH",
    "cacheNamespace": "b8ff32ea",
    "cacheKeyParameters": [],
    "integrationResponses": {
        "200": {
            "statusCode": 200,
            "responseTemplates": {
                "application/json": null
            }
        }
    }
}

λ aws --endpoint-url=http://192.168.99.100:4567  apigateway create-deployment --region us-east-1 --rest-api-id 453wplpxbd --stage-name dev
{
    "id": "nl5pcfrzxd",
    "description": "",
    "createdDate": "2020-06-09T00:01:09-03:00"
}

http://192.168.99.100:4567/restapis/453wplpxbd/dev/_user_request_/HowMuchIsTheFish


aws --endpoint-url=http://192.168.99.100:4581  cloudformation create-stack --stack-name myteststack --template-body file://./s3template.json --parameters ParameterKey=KeyPairName,ParameterValue=TestKey ParameterKey=SubnetIDs,ParameterValue=SubnetID1\\,SubnetID2
{
    "StackId": "arn:aws:cloudformation:us-east-1:000000000000:stack/myteststack/57e5e0df-1634-42d1-8759-713d3f80502a"
}


aws --endpoint-url=http://192.168.99.100:4581  cloudformation create-stack --stack-name my-stack-s3 --template-body file://./s3-template.json
{
    "StackId": "arn:aws:cloudformation:us-east-1:000000000000:stack/my-stack-s3/629b84a9-be41-4bdc-831c-23e68d351da9"
}

aws --endpoint-url=http://192.168.99.100:4572 s3 cp api_create.zip s3://my-bucket-lambda
aws --endpoint-url=http://192.168.99.100:4572 s3 cp api_update.zip s3://my-bucket-lambda
aws --endpoint-url=http://192.168.99.100:4572 s3 cp api_find.zip s3://my-bucket-lambda
aws --endpoint-url=http://192.168.99.100:4572 s3 cp api_delete.zip s3://my-bucket-lambda

agendamento_create/venv/Include/application.lambda_handler
aws --endpoint-url=http://192.168.99.100:4581  cloudformation create-stack --stack-name my-stack-lambda --template-body file://./original.json
{
    "StackId": "arn:aws:cloudformation:us-east-1:000000000000:stack/my-stack-lambda/4943c98b-8c08-4f9e-b224-c8749cc4aa27"
}

aws --endpoint-url=http://192.168.99.100:4569 dynamodb create-table --table-name Produto --attribute-definitions AttributeName=id,AttributeType=S AttributeName=nome,AttributeType=S --key-schema AttributeName=id,KeyType=HASH AttributeName=nome,KeyType=RANGE --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5

#Update Codigo
aws --endpoint-url=http://192.168.99.100:4572 s3 rm s3://my-bucket-lambda/api_create.zip
aws --endpoint-url=http://192.168.99.100:4572 s3 cp api_create.zip s3://my-bucket-lambda
aws --endpoint-url=http://192.168.99.100:4574 lambda update-function-code --function-name lambda_create --s3-bucket my-bucket-lambda --s3-key api_create.zip