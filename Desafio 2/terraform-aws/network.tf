resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/21"

  tags = {
    Name = "mp_leo"
  }
}

###############################################################################################################

# A

# SUBNET PÚBLICA A
resource "aws_subnet" "public_a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "mp_leo"
  }
}

# SUBNET PRIVADA A
resource "aws_subnet" "private_app_a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "mp_leo"
  }
}

# SUBNET PRIVADA (BANCO DADOS)
resource "aws_subnet" "private_db_a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "mp_leo"
  }
}

# ASSOSSIAÇÃO ROTA PÚBLICA
resource "aws_route_table_association" "public_a" {
  subnet_id = aws_subnet.public_a.id

  route_table_id = aws_route_table.router_public.id

}

#ASSOSSIAÇÃO ROTA PRIVADA
resource "aws_route_table_association" "private_app_a" {
  subnet_id = aws_subnet.private_app_a.id

  route_table_id = aws_route_table.router_private_a.id

}

#ASSOSSIAÇÃO ROTA PRIVADA (BANCO DADOS)
resource "aws_route_table_association" "private_db_a" {
  subnet_id = aws_subnet.private_db_a.id

  route_table_id = aws_route_table.router_private_a.id

}

###############################################################################################################

# C

# SUBNET PÚBLICA C
resource "aws_subnet" "public_c" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1c"

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

# ASSOSSIAÇÃO ROTA PÚBLICA
resource "aws_route_table_association" "public_c" {
  subnet_id = aws_subnet.public_c.id

  route_table_id = aws_route_table.router_public.id

}

# ASSOSSIAÇÃO ROTA PRIVADA
resource "aws_route_table_association" "private_app_c" {
  subnet_id = aws_subnet.private_app_c.id

  route_table_id = aws_route_table.router_private_c.id

}

#ASSOSIAÇÃO ROTA PRIVADA (BANCO DADOS)
resource "aws_route_table_association" "private_db_c" {
  subnet_id = aws_subnet.private_db_c.id

  route_table_id = aws_route_table.router_private_c.id

}

###############################################################################################################

# REDES

# ELASTIC IP 1(A)
resource "aws_eip" "nat" {
  vpc        = true
  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "mp_leo"
  }

}

# ELASTIC IP 2 (C)
resource "aws_eip" "nat2" {
  vpc        = true
  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "mp_leo"
  }

}

# INTERNET GATEWAY
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "mp_leo"
  }
}

# NATGATEWAY A
resource "aws_nat_gateway" "nat_gw_a" {
  allocation_id = aws_eip.nat.id 
  subnet_id     = aws_subnet.public_a.id

  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "mp_leo"
  }
}

# NATGATEWAY C
resource "aws_nat_gateway" "nat_gw_c" {
  allocation_id = aws_eip.nat2.id 
  subnet_id     = aws_subnet.public_c.id

  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "mp_leo"
  }
}

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

# ROTA PRIVADA C DEFINIDA
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

###############################################################################################################

# AUTO SCALING LAUNCH CONFIGURATION
resource "aws_launch_configuration" "aws_launch" {
  name = "custom-launch-config"
  image_id = ""
  instance_type = "t2.micro"
  key_name = "terraform-aws-mp"
}

# AUTO SCALING GROUP
resource "aws_autoscaling_group" "aws_group" {
  name                      = "aws_group"
  max_size                  = 3
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"
  force_delete              = true
  launch_configuration      = aws_launch_configuration.aws_launch.name
  vpc_zone_identifier       = ["${aws_security_group.acesso-ssh-mp.id}"]
  tag {
    key = "name"
    value = "ec2_desafio"
    propagate_at_launch = true
  }
}

# AUTO SCALING CONFIGURATION POLICY
resource "aws_autoscaling_policy" "aws_policy" {
  name                   = "aws_policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.aws_group.name
  policy_type = "SimpleScaling"
}

# CLOUD WATCH MONITORING
resource "aws_cloudwatch_metric_alarm" "aws_alarm" {
  alarm_name                = "aws_alarm"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 2
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 120
  statistic                 = "Average"
  threshold                 = 20
  alarm_description         = "Alarme para monitoração do serviço cloud"

  dimensions = {
    "AutoScalingGroupName": aws_autoscaling_group.aws_group.name
  }
  actions_enabled = true
  alarm_actions = [aws_autoscaling_policy.aws_police.arn]
}

# AUTO DESCALING POLICY
resource "aws_autoscaling_policy" "aws_policy_scaledown" {
  name                   = "aws_policy_scaledown"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = aws_autoscaling_group.aws_group.name
  policy_type = "SimpleScaling"
}

# DESCALING CLOUD WATCH
resource "aws_cloudwatch_metric_alarm" "aws_alarm_scaledown" {
  alarm_name                = "aws_alarm_scaledown"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 2
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 120
  statistic                 = "Average"
  threshold                 = 20
  alarm_description         = "Alarme para monitoração do serviço de saída da cloud"

  dimensions = {
    "AutoScalingGroupName": aws_autoscaling_group.aws_group.name
  }
  actions_enabled = true
  alarm_actions = [aws_autoscaling_policy.aws_police.arn]
}

###############################################################################################################

# LOAD BALANCER
resource "aws_elb" "elb" {
}








