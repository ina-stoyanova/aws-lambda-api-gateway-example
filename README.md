# Hello World app using Golang, AWS Lambda & API Gateway (with Terraform)

This repo contains an example of a simple hello-world app using AWS Lambda, API Gateway and S3.

[Check here](https://ey2izkyq09.execute-api.eu-central-1.amazonaws.com/demo/) if it works!

## Tech stack initially chosen
- Terraform v1.4.6
- Golang go1.19.9
- AWS Lambda 
- API Gateway V2
- S3 bucket
- CloudWatch Logs

## Ways of working 
1. Write the most simple Lambda function using Go
   2. Test the function using the AWS console and AWS CLI
2. Create TF configuration for the resources needed 
3. Troubleshoot & ensure it works when I hit the endpoint exposed by the API
4. Figure out next steps for improving this demo

## Next steps
- [ ] Add a CICD pipeline using GH Actions for the app deployment to the S3 bucket
- [ ] Add a CICD pipeline for the infra changes 
- [ ] Add a Function URL 
- [ ] Secure the endpoints exposed by the API Gateway
  - [ ] allow only `GET/` actions
  - [ ] enable CORS
- [ ] Limit the role permissions of the Lambda function to just the necessary ones

