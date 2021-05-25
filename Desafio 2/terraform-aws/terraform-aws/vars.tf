variable "amis" {
  type = map(any)

  default = {
    "us-east-1" = "ami-09e67e426f25ce0d7"
  }
}

variable "cdirs_acesso_remoto" {
  type    = list(any)
  default = ["10.0.0.0/21"]

}

variable "key_name" {
  default = "terraform-aws-mp"

}



