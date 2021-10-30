# TODO: Define the variable for aws_region
variable "lambda_function_name" {
  default = "lambda_function_name"
}

variable "access_key" {
    default = 
    sensitive = true
}

variable "secret_key" {
    default = 
    sensitive = true
}

variable "region" {
    default = "us-east-1"
}
