# ROTA PÚBLICA DEFINIDA
resource "aws_route_table" "router_public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "mp_leo"
  }
}

##########################################################
# AVAILABILITY ZONE A

# ROTA PRIVADA A DEFINIDA
resource "aws_route_table" "router_private_a" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_a.id
  }

  tags = {
    Name = "mp_leo"
  }
}

# ASSOSSIAÇÃO ROTA PÚBLICA A
resource "aws_route_table_association" "public_a" {
  subnet_id = aws_subnet.public_a.id

  route_table_id = aws_route_table.router_public.id

}

#ASSOSSIAÇÃO ROTA PRIVADA (APP) A
resource "aws_route_table_association" "private_app_a" {
  subnet_id = aws_subnet.private_app_a.id

  route_table_id = aws_route_table.router_private_a.id

}

#ASSOSSIAÇÃO ROTA PRIVADA (BANCO DADOS) A
resource "aws_route_table_association" "private_db_a" {
  subnet_id = aws_subnet.private_db_a.id

  route_table_id = aws_route_table.router_private_a.id

}

#################################################################

# AVAILABILITY ZONE C

#ROTA PRIVADA C DEFINIDA
resource "aws_route_table" "router_private_c" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_c.id
  }

  tags = {
    Name = "mp_leo"
  }
}

# ASSOSSIAÇÃO ROTA PÚBLICA C
resource "aws_route_table_association" "public_c" {
  subnet_id = aws_subnet.public_c.id

  route_table_id = aws_route_table.router_public.id

}

# ASSOSSIAÇÃO ROTA PRIVADA (APP) C
resource "aws_route_table_association" "private_app_c" {
  subnet_id = aws_subnet.private_app_c.id

  route_table_id = aws_route_table.router_private_c.id

}

#ASSOSIAÇÃO ROTA PRIVADA (BANCO DADOS) C
resource "aws_route_table_association" "private_db_c" {
  subnet_id = aws_subnet.private_db_c.id

  route_table_id = aws_route_table.router_private_c.id

}



