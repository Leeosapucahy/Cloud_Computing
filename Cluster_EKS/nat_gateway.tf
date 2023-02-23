#NAT GATEWAY A
resource "aws_nat_gateway" "nat_gw_a" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_a.id

  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "mp_leo"
  }
}

#NAT GATEWAY C
resource "aws_nat_gateway" "nat_gw_c" {
  allocation_id = aws_eip.nat2.id
  subnet_id     = aws_subnet.public_c.id

  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "mp_leo"
  }
}