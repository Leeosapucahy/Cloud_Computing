resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/21"
  enable_dns_hostnames = true

  tags = {
    Name = "mp_leo"
  }
}

###############################################################################################################

# AVAILABILITY ZONE A

# SUBNET PÚBLICA A
resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "mp_leo"
  }
}

# SUBNET PRIVADA (APP) A
resource "aws_subnet" "private_app_a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "mp_leo"
  }
}

# SUBNET PRIVADA (BANCO DADOS) A
resource "aws_subnet" "private_db_a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "mp_leo"
  }
}



###############################################################################################################

# AVAILABILITY ZONE C

# SUBNET PÚBLICA C
resource "aws_subnet" "public_c" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "mp_leo"
  }
}

# SUBNET PRIVADA C
resource "aws_subnet" "private_app_c" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "mp_leo"
  }
}

# SUBNET PRIVADA C (BANCO DADOS)
resource "aws_subnet" "private_db_c" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.7.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "mp_leo"
  }
}

