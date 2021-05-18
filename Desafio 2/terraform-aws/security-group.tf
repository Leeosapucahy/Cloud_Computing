resource "aws_security_group" "acesso-ssh-mp" {
  name        = "acesso-ssh-mp"
  description = "acesso-ssh-mp"


  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.cdirs_acesso_remoto

  }


  tags = {
    Name = "ssh"
  }
}

