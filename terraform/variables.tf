variable "aws_access_key_id" {
  type = string
  description = "AWS access key of the user "
  validation {
    condition = length(var.aws_access_key_id) > 0
    error_message = "AWS access key of the user must be not empty"
  }
}
variable "aws_secret_access_key" {
  description = "AWS secret access key of the user "
  type = string
  validation {
    condition = length(var.aws_secret_access_key) > 0
    error_message = "AWS secret access key of the user must be not empty"
  }
}
variable "region" {
  type = string
  default = "us-east-1"
}
variable "project_name" {
  type = string
  default = "LabOS"
}
variable "tier" {
  type = string
  default = "Dev"
}
variable "path_to_public_key" {
  type = string
  default = "/home/lidorabo/.ssh/ec2.pub"
}