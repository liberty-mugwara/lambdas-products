@echo off
build.windows.bat && ^
for /f "delims=" %%x in (.cli.env) do ^
aws lambda create-function --function-name ArchiveProductQuantityData^
 --runtime python3.9^
 --zip-file fileb://build/lambda.zip^
 --role arn:aws:iam::876738331715:role/RDS_cloudWatch_S3_Lambda_Acess^
 --handler ArchiveProductQuantityData.lambda_handler^
 --timeout 300^
 --memory-size 2000^
 --publish^
 --package-type Zip^
 --environment Variables=%%x^
 --layers arn:aws:lambda:eu-central-1:336392948345:layer:AWSSDKPandas-Python39:2^
 arn:aws:lambda:eu-central-1:876738331715:layer:sqlalchemy:1
