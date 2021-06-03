variable "amis" {
  type = map(any)

  default = {
    "us-east-1a" = "ami-09e67e426f25ce0d7"
  }
}

variable "cdirs_acesso_remoto" {
  type    = list(any)
  default = ["0.0.0.0/0"]

}

variable "key_name" {
  default = "terraform-aws-mp"

}

variable "password" {
  default = "12345678"

}

variable "user" {
  default = "admin"

}





