resource "aws_instance" "bastion_sever" {
  ami           = var.amis["us-east-1a"]
  instance_type = "t2.micro"
  key_name      = var.key_name
  subnet_id     = aws_subnet.public_a.id
  tags = {
    "Name" = "mp_leo-bastion_server"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso-ssh-mp.id}"]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("/home/marcos/.ssh/terraform-aws-mp")
    host        = self.public_dns
  }

  provisioner "file" {
    source      = "/home/marcos/.ssh/terraform-aws-mp"
    destination = "/home/ubuntu/"
  }

  provisioner "remote-exec"{
    inline = [
    "chmod 700 terraform-aws-mp",
    "sudo apt install mysql-client-core-8.0",
    "mysql -h ${aws_db_instance.database.address} -P 3306 -u ${var.user} -p${var.password} < database.sql"
  ]
  }

}
