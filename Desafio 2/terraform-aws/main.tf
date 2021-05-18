resource "aws_instance" "webserver" {
  count         = 2
  ami           = var.amis["us-east-1"]
  instance_type = "t2.micro"
  key_name      = "terraform-aws-mp"
  tags = {
    "Name" = "webserver${count.index}"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso-ssh-mp.id}"]

}

# resource "aws_s3_bucket" "bucket_sre" {
#   bucket = "bucket_sre"
#   acl    = "private"

#   tags = {
#     "Name" = "mp_leo"
#   }

# }
