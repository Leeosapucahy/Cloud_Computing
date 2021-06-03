resource "aws_launch_configuration" "lc_clientes" {
  name_prefix     = "api_clientes"
  image_id        = "ami-09c9061e80000f265"
  key_name        = var.key_name
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.apis.id]

}

resource "aws_launch_configuration" "lc_catalogo" {
  name_prefix     = "api_catalogo"
  image_id        = "ami-07a617a70b84c9032"
  key_name        = var.key_name
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.apis.id]

}

resource "aws_launch_configuration" "lc_inventario" {
  name_prefix     = "api_inventario"
  image_id        = "ami-027251dec79c86570"
  key_name        = var.key_name
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.apis.id]


}

# 3 Auto Scaling
resource "aws_autoscaling_group" "asg_clientes" {
  name                = "api_clientes"
  desired_capacity    = 2 # Instâncias desejadas
  max_size            = 4 # Máximo instâncias
  min_size            = 2 # Mínimo instâncias
  vpc_zone_identifier = [aws_subnet.private_app_a.id, aws_subnet.private_app_c.id]

  launch_configuration = aws_launch_configuration.lc_clientes.name

  health_check_grace_period = 300
  health_check_type         = "ELB" # Cria os alarmes de instrução
  target_group_arns         = [aws_lb_target_group.my_alb_target_group1.arn]

  tag {
    key                 = "Name"
    value               = "mp_leo-api_clientes"
    propagate_at_launch = true
  }

}

resource "aws_autoscaling_group" "asg_catalogo" {
  name                = "api_catalogo"
  desired_capacity    = 2 # Instâncias desejadas
  max_size            = 4 # Máximo instâncias
  min_size            = 2 # Mínimo instâncias
  vpc_zone_identifier = [aws_subnet.private_app_a.id, aws_subnet.private_app_c.id]

  launch_configuration = aws_launch_configuration.lc_catalogo.name

  health_check_grace_period = 300
  health_check_type         = "ELB" # Cria os alarmes de instrução
  target_group_arns         = [aws_lb_target_group.my_alb_target_group2.arn]

  tag {
    key                 = "Name"
    value               = "mp_leo-api_catalogo"
    propagate_at_launch = true
  }

}

resource "aws_autoscaling_group" "asg_inventario" {
  name                = "api_inventario"
  desired_capacity    = 2 # Instâncias desejadas
  max_size            = 4 # Máximo instâncias
  min_size            = 2 # Mínimo instâncias
  vpc_zone_identifier = [aws_subnet.private_app_a.id, aws_subnet.private_app_c.id]

  launch_configuration = aws_launch_configuration.lc_inventario.name

  health_check_grace_period = 300
  health_check_type         = "ELB" # Cria os alarmes de instrução
  target_group_arns         = [aws_lb_target_group.my_alb_target_group3.arn]

  tag {
    key                 = "Name"
    value               = "mp_leo-api_inventario"
    propagate_at_launch = true
  }

}