# AWS Key Pair Resource
resource "aws_key_pair" "keypair" {
  key_name   = var.aws_key_name
  public_key = file(var.aws_public_key_path)
}

# Security Group for SSH
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from anywhere; adjust for production
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP from anywhere
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# AWS EC2 Instance
resource "aws_instance" "docker_host" {
  ami           = "ami-0d64bb532e0502c46"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.keypair.key_name
  security_groups = [aws_security_group.allow_ssh.name]

  tags = {
    Name = "DockerHost"
  }

  # Install Docker on EC2 Instance
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y docker.io",
      "sudo systemctl start docker",
      "sudo systemctl enable docker"
    ]

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file(var.aws_private_key_path)
    }
  }

  # Run Docker Container on EC2 Instance
  provisioner "remote-exec" {
    inline = [
      "sudo docker run -d -p ${var.docker_port_external}:${var.docker_port_internal} --name ${var.docker_container_name} ${var.docker_image_name}"
    ]

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file(var.aws_private_key_path)
    }
  }
}

# Output the Public IP of the Instance
output "instance_public_ip" {
  value = aws_instance.docker_host.public_ip
}