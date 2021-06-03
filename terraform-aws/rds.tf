resource "aws_db_instance" "database" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t2.micro"
  name                 = "mp_leo"
  username             = var.user
  password             = var.password
  identifier           = "mpleo"
  publicly_accessible  = true
  skip_final_snapshot  = true
  port                 = 3306
  multi_az             = true
  db_subnet_group_name = aws_db_subnet_group.dbsg.id
  vpc_security_group_ids = ["${aws_security_group.acesso-ssh-mp.id}"]
  tags = {
    "name" = "mp_leo"
  }
}

resource "aws_db_subnet_group" "dbsg" {
  name       = "mp_leo"
  subnet_ids = [aws_subnet.private_db_a.id, aws_subnet.private_db_c.id]


}
