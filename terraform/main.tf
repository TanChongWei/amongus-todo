variable "name" {
	type = string
	default = "cwdevtoolshw4"
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
  key_name   = "server"
  public_key = tls_private_key.private_key.public_key_openssh
}

resource "aws_security_group" "allow_app_servers" {
	name = "allow-port-22"

	ingress {
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["58.182.83.212/32"]
	}

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

	tags = {
		Name = "allow_app_servers"
	}
}

resource "aws_instance" "cw-hw4" {
	ami = "ami-0f511ead81ccde020"
	instance_type = "t2.micro"
	key_name = aws_key_pair.server_key.key_name
  vpc_security_group_ids = [aws_security_group.allow_app_servers.name]

	tags = {
		Name = var.name
	}
}

output "instance_ips" {
	value = [aws_instance.cw-hw4.public_ip]
}

output "instance_ids" {
	value = [aws_instance.cw-hw4.id]
}