resource "aws_security_group" "ec2_sg" {
  name        = "ec2-security-group"
  description = "Allow SSH and React app traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8563
    to_port     = 8563
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "Music_Discovery" {
    ami = var.ami_value
    instance_type = var.instance_type
    key_name      = var.your-key-pair
    vpc_security_group_ids = [aws_security_group.ec2_sg.id]

    user_data = templatefile("${path.module}/userdata.tpl", {
    react_port = var.react_port
    Music_Discovery_repo_url = var.Music_Discovery_repo_url
    Music_Discovery_playwright_repo_url = var.Music_Discovery_playwright_repo_url
    })
}
