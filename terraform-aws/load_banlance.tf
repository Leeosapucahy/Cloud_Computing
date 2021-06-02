resource "aws_lb" "Loadbalancer" {
  name            = "Loadbalancer-mp-leo"
  security_groups = [aws_security_group.apis.id]
  subnets = [
    aws_subnet.public_a.id,
    aws_subnet.public_c.id
  ]
  internal = false
}

# 3 Listeners
resource "aws_lb_listener" "my_alb_listener" {
  load_balancer_arn = aws_lb.Loadbalancer.arn
  port              = 5000
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.my_alb_target_group.arn
    type             = "forward"
  }
}

resource "aws_lb_listener" "my_alb_listener1" {
  load_balancer_arn = aws_lb.Loadbalancer.arn
  port              = 5001
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.my_alb_target_group1.arn
    type             = "forward"
  }
}

resource "aws_lb_listener" "my_alb_listener2" {
  load_balancer_arn = aws_lb.Loadbalancer.arn
  port              = 5002
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.my_alb_target_group2.arn
    type             = "forward"
  }
}

# 3 Targets Group
resource "aws_lb_target_group" "my_alb_target_group" {
  name     = "target-group-mp-leo"
  port     = 5000
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
  health_check {
    interval            = 300
    path                = "/"           # Colocar o caminho das APIS (/catalogo, /inventario etc...)
    port                = 5000          # Porta API
    healthy_threshold   = 3             # Total testes para saber se está certo
    unhealthy_threshold = 3             # Total testes para saber se está errado
    timeout             = 4             # Tentativas totais
    protocol            = "HTTP"        # Segurança
    matcher             = "200,201,401" # Códigos de HTTP
  }
}

resource "aws_lb_target_group" "my_alb_target_group1" {
  name     = "target-group-mp-leo1"
  port     = 5000
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
  health_check {
    interval            = 300
    path                = "/"  # Colocar o caminho das APIS (/catalogo, /inventario etc...)
    port                = 5000 # Porta API
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 4
    protocol            = "HTTP"
    matcher             = "200,201,401"
  }
}

resource "aws_lb_target_group" "my_alb_target_group2" {
  name     = "target-group-mp-leo2"
  port     = 5000
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
  health_check {
    interval            = 300
    path                = "/"  # Colocar o caminho das APIS (/catalogo, /inventario etc...)
    port                = 5000 # Porta API
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 4
    protocol            = "HTTP"
    matcher             = "200,201,401"
  }
}