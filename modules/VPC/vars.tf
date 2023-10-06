variable "vpc_cidr" {
    type = string
    default = "10.0.0.0/16"
  }

variable "vpc_tags" {
   default = {
    Name = "FlaskApplication-VPC"
    Environment = "Production"
    Owner = "Abilash"
   }
}

 
variable "pub_cidrs" {
  default = ["10.200.0.0/24", "10.200.1.0/24"]
  
}

 