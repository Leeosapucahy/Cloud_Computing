#ELASTIC IP 1(A)
resource "aws_eip" "nat" {
  vpc        = true
  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "mp_leo"
  }

}

#ELASTIC IP 2 (C)
resource "aws_eip" "nat2" {
  vpc        = true
  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "mp_leo"
  }

}