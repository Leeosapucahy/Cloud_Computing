resource "aws_instance" "webserver" {
  ami           = var.amis["us-east-1"]
  instance_type = "t2.micro"
  key_name      = "terraform-aws-mp"
  tags = {
    "Name" = "mp_leo"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso-ssh-mp.id}"]

}

resource "aws_instance" "webserver1" {
  ami           = var.amis["us-east-1"]
  instance_type = "t2.micro"
  key_name      = "terraform-aws-mp"
  tags = {
    "Name" = "mp_leo"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso-ssh-mp.id}"]

}

resource "aws_instance" "webserver2" {
  ami           = var.amis["us-east-1"]
  instance_type = "t2.micro"
  key_name      = "terraform-aws-mp"
  tags = {
    "Name" = "mp_leo"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso-ssh-mp.id}"]

}