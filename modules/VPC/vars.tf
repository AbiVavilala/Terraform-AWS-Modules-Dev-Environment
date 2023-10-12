variable "vpc_cidr" {
     
  }

variable "vpc_tags" {
   default = {
    Name = "FlaskApplication-VPC"
    Environment = "Production"
    Owner = "Abilash"
   }
}

variable "pub_cidrs" {
  
}
 
variable "pri_cidrs" {
   
}