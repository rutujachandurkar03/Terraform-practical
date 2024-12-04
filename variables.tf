# AWS Variables
variable "aws_region" {
  description = "The AWS region where resources will be created"
  type        = string
  default     = "eu-west-1"
}

# AWS Key Pair Name
variable "aws_key_name" {
  description = "The name of the AWS key pair to use for SSH access"
  type        = string
  default     = "keypair"
}

# Public Key for AWS Key Pair
variable "aws_public_key_path" {
  description = "The path to the public key file for the key pair"
  type        = string
  default     = "C:/Users/ASUS/Desktop/terraform-practical/terraform-Day02/keypair.pub"
}

# Path to Private Key for SSH
variable "aws_private_key_path" {
  description = "The path to the private key file for SSH access to the EC2 instance"
  type        = string
  default     = "C:/Users/ASUS/Desktop/terraform-practical/terraform-Day02/keypair"
}


# Docker Container Image
variable "docker_image_name" {
  description = "The name of the Docker image to run"
  type        = string
  default     = "nginx:latest"
}

# Docker Container Name
variable "docker_container_name" {
  description = "The name of the Docker container"
  type        = string
  default     = "nginx_container"
}

# Docker Container Ports
variable "docker_port_external" {
  description = "The external port to expose the Docker container"
  type        = number
  default     = 80
}

variable "docker_port_internal" {
  description = "The internal port of the Docker container"
  type        = number
  default     = 80
}
