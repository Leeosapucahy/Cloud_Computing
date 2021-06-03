resource "aws_lb" "Loadbalancer" {
  name            = "Loadbalancer-mp-leo"
  security_groups = [aws_security_group.apis.id, aws_security_group.acesso-ssh-mp.id]
  subnets = [
    aws_subnet.public_a.id,
    aws_subnet.public_c.id
  ]
  internal = false
}

# Listeners
resource "aws_lb_listener" "my_alb_listener1" {
  load_balancer_arn = aws_lb.Loadbalancer.arn
  port              = 5000
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.my_alb_target_group1.arn
    type             = "forward"
  }
}

resource "aws_lb_listener" "my_alb_listener2" {
  load_balancer_arn = aws_lb.Loadbalancer.arn
  port              = 5001
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.my_alb_target_group2.arn
    type             = "forward"
  }
}

resource "aws_lb_listener" "my_alb_listener3" {
  load_balancer_arn = aws_lb.Loadbalancer.arn
  port              = 5002
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.my_alb_target_group3.arn
    type             = "forward"
  }
}

# Targets Group
resource "aws_lb_target_group" "my_alb_target_group1" {
  name     = "target-group-mp-leo1"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
  health_check {
    interval            = 300
    path                = "/clientes"           # Colocar o caminho das APIS (/catalogo, /inventario etc...)
    port                = 5000          # Porta API
    healthy_threshold   = 3             # Total testes para saber se está certo
    unhealthy_threshold = 3             # Total testes para saber se está errado
    timeout             = 4             # Tentativas totais
    protocol            = "HTTP"        # Segurança
    matcher             = "200,201,401" # Códigos de HTTP
  }
}

resource "aws_lb_target_group" "my_alb_target_group2" {
  name     = "target-group-mp-leo2"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
  health_check {
    interval            = 300
    path                = "/catalogo"  # Colocar o caminho das APIS (/catalogo, /inventario etc...)
    port                = 5001 # Porta API
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 4
    protocol            = "HTTP"
    matcher             = "200,201,401"
  }
}

resource "aws_lb_target_group" "my_alb_target_group3" {
  name     = "target-group-mp-leo3"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
  health_check {
    interval            = 300
    path                = "/inventario"  # Colocar o caminho das APIS (/catalogo, /inventario etc...)
    port                = 5002 # Porta API
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 4
    protocol            = "HTTP"
    matcher             = "200,201,401"
  }
}