
resource "aws_db_instance" "database" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t2.micro"
  name                 = "mp_leo"
  username             = "admin"
  password             = "12345678"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.db_subnet.id
  tags = {
    "name" = "mp_leo"
  }
}

resource "aws_db_subnet_group" "db_subnet" {
  name       = "mp_leo"
  subnet_ids = [aws_subnet.private_db_a.id, aws_subnet.private_db_c.id]

}