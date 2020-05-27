provider "aws" {
    region = var.aws_region
}

resource "aws_lambda_function" "project2_exercise2_labmda_function" {
    filename = "greet_lambda_payload.zip"
    function_name = "greet_lambda"
    handler = "greet_lambda.lambda_handler"
    runtime = "python3.8"
    environment {
      variables = {
        greeting = "Hello"
      }
    }
    tags = {
      project = "project2"
    }
    role = aws_iam_role.project2_exercise2_lamda_exec_role.arn
    source_code_hash = filebase64sha256("greet_lambda_payload.zip")
    depends_on    = [aws_iam_role_policy_attachment.project2_exercise2_lambda_logs]
}

resource "aws_iam_role" "project2_exercise2_lamda_exec_role" {
    name = "project2_exercise2_lamda_exec_role"
    path = "/"
    tags = {
      project = "project2"
    }    
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"        
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "project2_exercise2_lamda_logging_policy" {
  name = "project2_exercise2_lamda_logging_policy"
  path = "/"  

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

resource "aws_iam_role_policy_attachment" "project2_exercise2_lambda_logs" {
  role = aws_iam_role.project2_exercise2_lamda_exec_role.name
  policy_arn = aws_iam_policy.project2_exercise2_lamda_logging_policy.arn  
}