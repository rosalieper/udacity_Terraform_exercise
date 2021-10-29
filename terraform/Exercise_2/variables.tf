# TODO: Define the variable for aws_region
variable "lambda_function_name" {
  default = "lambda_function_name"
}

variable "access_key" {
    default = "AKIAVHSJ7MYDUOTSL3ML"
    sensitive = true
}

variable "secret_key" {
    default = "O0l1qNtY9rAQzYFML4HW2N99LV1nVqFHvJHm26TS"
    sensitive = true
}

variable "region" {
    default = "us-east-1"
}