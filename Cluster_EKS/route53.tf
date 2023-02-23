# Para fixar o endpoint do banco de dados
#resource "aws_route53_zone" "route53" {
 # name = "route53-zone-mp_leo"

  #vpc {
   # vpc_id = aws_vpc.vpc.id
  #}

#}

#resource "aws_route53_record" "route53_record" {
 # zone_id = aws_route53_zone.route53.id
  #name    = "rds"
  #type    = "CNAME"
  #ttl     = "300"
  #records = ["${aws_db_instance.database.address}"]

#}


