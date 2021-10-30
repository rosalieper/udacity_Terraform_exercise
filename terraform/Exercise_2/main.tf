provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region = var.region
}

data "archive_file" "lambda-archive" {
  type = "zip"
  source_file = "lambda.py"
  output_path = "lambda.zip"
}

resource "aws_lambda_function" "lambda_function" {
  
  function_name = var.lambda_function_name
  filename = "lambda.zip"
  handler = "lambda.lambda_handler"
  role = aws_iam_role.iam_for_lambda.arn
  source_code_hash = filebase64sha256("lambda.zip")
  runtime       = "python3.6"

  depends_on = [
    aws_iam_role_policy_attachment.lambda_logs,
  ]
 
  environment {
      variables = {
        greeting = "Hello World from lambda function!"
      }
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "lambda_logging" {
  name        = "lambda_logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}