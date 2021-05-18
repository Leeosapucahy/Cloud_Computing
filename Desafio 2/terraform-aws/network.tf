resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/21"

  tags = {
    Name = "mp_leo"
  }
}

resource "aws_subnet" "public_a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "mp_leo"
  }
}

resource "aws_subnet" "public_c" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "mp_leo"
  }
}

resource "aws_subnet" "private_app_a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "mp_leo"
  }
}

resource "aws_subnet" "private_app_c" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "mp_leo"
  }
}

resource "aws_subnet" "private_db_a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "mp_leo"
  }
}

resource "aws_subnet" "private_db_c" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.7.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "mp_leo"
  }
}

resource "aws_eip" "nat" {
  vpc        = true
  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "mp_leo"
  }

}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "mp_leo"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat.id
  subnet_id = aws_subnet.private_app_a.id

  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "mp_leo"
  }

}

resource "aws_route_table" "router" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "mp_leo"
  }

}


resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.router.id

}

resource "aws_route_table_association" "private" {
  subnet_id = aws_subnet.private_app_a.id
   
  route_table_id = aws_route_table.router.id

}
