resource "aws_db_instance" "database" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t2.micro"
  name                 = "mp_leo"
  username             = var.user
  password             = var.password
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.dbsg.id
  tags = {
    "name" = "mp_leo"
  }
}

resource "aws_db_subnet_group" "dbsg" {
  name       = "mp_leo"
  subnet_ids = [aws_subnet.private_db_a.id, aws_subnet.private_db_c.id]

}

# provisioner "remote-exec" {
#   inline = [
#     "chmod 700 mykey",
#     "sudo apt install mysql-client-core-8.0",
#     "mysql -h ${aws_db_instance.DB.address} -P 3306 -u ${var.db_user} -p${var.db_password} < schema.sql"
#   ]
# }
