resource "aws_elb" "Load_balance" {
  name    = "10"
  #Interanl = false
  #Load_balancer_type = "application"
  subnets = [ 
    aws_subnet.public_a.id,
    aws_subnet.public_c.id
  ]


  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  listener {
    instance_port      = 8000
    instance_protocol  = "http"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = "arn:aws:iam::808485220920:user/marcos.fernandes"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

  instances                   = [aws_instance.webserver.id, aws_instance.webserver1.id, aws_instance.webserver2.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400
  tags = {
    Name = "mp_leo"
  }
}