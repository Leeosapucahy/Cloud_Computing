resource "aws_launch_template" "asg_sre" {
  name_prefix   = "asg"
  image_id      = "ami-09e67e426f25ce0d7"
  instance_type = "t2.micro"
  tags = {
    "Name" = "mp_leo"
  }
}

resource "aws_autoscaling_group" "asg" {
  availability_zones = ["us-east-1a", "us-east-1c"]
  desired_capacity   = 1
  max_size           = 3
  min_size           = 1

  launch_template {
    id      = aws_launch_template.asg_sre.id
    version = "$Latest"
  }
}