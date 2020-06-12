#!/bin/sh

API_NAME=api
REGION=us-east-1
STAGE=dev

function fail() {
    echo $2
    exit $1
}

aws --endpoint-url=http://192.168.99.100:4572 lambda create-function \
    --region ${REGION} \
    --function-name ${API_NAME} \
    --runtime python3.8 \
    --handler lambda_function.lambda_handler \
    --memory-size 128 \
    --zip-file fileb:///Users/gerem/PycharmProjects/lambda_function.zip \
    --role arn:aws:iam::123456:role/irrelevant

[ $? == 0 ] || fail 1 "Failed: AWS / lambda / create-function"

LAMBDA_ARN=$(aws --endpoint-url=http://192.168.99.100:4572 lambda list-functions --query "Functions[?FunctionName==\`${API_NAME}\`].FunctionArn" --output text --region ${REGION})

aws --endpoint-url=http://192.168.99.100:4567 apigateway create-rest-api \
    --region ${REGION} \
    --name ${API_NAME}

[ $? == 0 ] || fail 2 "Failed: AWS / apigateway / create-rest-api"

API_ID=$(aws --endpoint-url=http://192.168.99.100:4567 apigateway get-rest-apis --query "items[?name==\`${API_NAME}\`].id" --output text --region ${REGION})
PARENT_RESOURCE_ID=$(aws --endpoint-url=http://192.168.99.100:4567 apigateway get-resources --rest-api-id ${API_ID} --query 'items[?path==`/`].id' --output text --region ${REGION})

aws --endpoint-url=http://192.168.99.100:4567 apigateway create-resource \
    --region ${REGION} \
    --rest-api-id ${API_ID} \
    --parent-id ${PARENT_RESOURCE_ID} \
    --path-part "{somethingId}"

[ $? == 0 ] || fail 3 "Failed: AWS / apigateway / create-resource"

RESOURCE_ID=$(aws --endpoint-url=http://192.168.99.100:4567 apigateway get-resources --rest-api-id ${API_ID} --query 'items[?path==`/{somethingId}`].id' --output text --region ${REGION})

aws --endpoint-url=http://192.168.99.100:4567 apigateway put-method \
    --region ${REGION} \
    --rest-api-id ${API_ID} \
    --resource-id ${RESOURCE_ID} \
    --http-method GET \
    --request-parameters "method.request.path.somethingId=true" \
    --authorization-type "NONE" \

[ $? == 0 ] || fail 4 "Failed: AWS / apigateway / put-method"

aws --endpoint-url=http://192.168.99.100:4567 apigateway put-integration \
    --region ${REGION} \
    --rest-api-id ${API_ID} \
    --resource-id ${RESOURCE_ID} \
    --http-method GET \
    --type AWS_PROXY \
    --integration-http-method POST \
    --uri arn:aws:apigateway:${REGION}:lambda:path/2015-03-31/functions/${LAMBDA_ARN}/invocations \
    --passthrough-behavior WHEN_NO_MATCH \

[ $? == 0 ] || fail 5 "Failed: AWS / apigateway / put-integration"

aws --endpoint-url=http://192.168.99.100:4567 apigateway create-deployment \
    --region ${REGION} \
    --rest-api-id ${API_ID} \
    --stage-name ${STAGE} \

[ $? == 0 ] || fail 6 "Failed: AWS / apigateway / create-deployment"

ENDPOINT=http://192.168.99.100:4567/restapis/${API_ID}/${STAGE}/_user_request_/HowMuchIsTheFish

echo "API available at: ${ENDPOINT}"

echo "Testing GET:"
curl -i ${ENDPOINT}

echo "Testing POST:"
curl -iX POST ${ENDPOINT}