data "archive_file" "lambda_code" {
  type        = "zip"
  source_file = "${path.module}/lambda/src/main"
  output_path = "${path.module}/lambda/src/main.zip"
}

resource "aws_s3_bucket" "lambda-code-gateway-demo" {
  bucket = "lambda-code-gateway-demo"

  tags = {
    Name = "Lambda API Gateway demo code bucket"
  }
}

resource "aws_s3_bucket_versioning" "versioned_demo_bucket" {
  bucket = aws_s3_bucket.lambda-code-gateway-demo.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_object" "lambda-code" {
  bucket = aws_s3_bucket.lambda-code-gateway-demo.id
  key    = "main.zip"
  source = data.archive_file.lambda_code.output_path
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }
    ]
  })
}

resource "aws_lambda_function" "lambda_demo" {
  function_name = "lambda_gateway_demo"
  role = aws_iam_role.iam_for_lambda.arn
  handler = "main"
  runtime = "go1.x"


  s3_bucket = aws_s3_object.lambda-code.bucket
  s3_key    = aws_s3_object.lambda-code.key
}

#resource "aws_iam_role" "lambda_role_exec" {
#  name = "lambda_gw_demo"
#
#  assume_role_policy = jsonencode({
#    Version = "2012-10-17"
#    Statement = [{
#      Action = "sts:AssumeRole"
#      Effect = "Allow"
#      Sid    = ""
#      Principal = {
#        Service = "lambda.amazonaws.com"
#      }
#    }
#    ]
#  })
#}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}