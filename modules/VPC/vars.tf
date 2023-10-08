variable "vpc_cidr" {
    type = string
    default = "10.200.0.0/16"
  }

variable "vpc_tags" {
   default = {
    Name = "FlaskApplication-VPC"
    Environment = "Production"
    Owner = "Abilash"
   }
}

variable "pub_cidrs" {
 default  = ["10.200.0.0/24", "10.200.1.0/24"]
  
}
 
variable "pri_cidrs" {
  default = ["10.200.2.0/24", "10.200.3.0/24"]
}