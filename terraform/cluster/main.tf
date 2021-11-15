variable "name" {
	type = string
	default = "cwdevtoolscapstone"
}

data "aws_vpc" "default_vpc" {
  default = true
}

resource "tls_private_key" "private_key" {
	algorithm = "RSA"
}

resource "local_file" "private_key" {
	content = tls_private_key.private_key.private_key_pem
	filename = "server.pem"
}

resource "aws_key_pair" "server_key" {
  key_name   = "capstone_private_key"
  public_key = tls_private_key.private_key.public_key_openssh
}

resource "aws_ecr_repository" "cwdevtoolscapstone" {
	name = "cwdevtoolscapstone"
	image_tag_mutability = "MUTABLE"

	image_scanning_configuration {
		scan_on_push = true
	}
}

resource "aws_security_group" "allowed_connections" {
	name = "allowed_connections"

	ingress {
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
	}

	ingress {
		from_port = 80
		to_port = 80
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

	tags = {
		Name = "allowed_connections"
	}
}

resource "aws_instance" "cw_devtools_capstone" {
	ami = "ami-0f511ead81ccde020"
	instance_type = "t2.micro"
	key_name = aws_key_pair.server_key.key_name
  vpc_security_group_ids = [aws_security_group.allowed_connections.name]

	tags = {
		Name = var.name
	}
}

output "instance_ips" {
	value = [aws_instance.cw_devtools_capstone.public_ip]
}

output "instance_ids" {
	value = [aws_instance.cw_devtools_capstone.id]
}