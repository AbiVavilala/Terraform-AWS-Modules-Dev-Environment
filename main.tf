module "FlaskVPC" {
    source = "./modules/VPC"
    vpc_cidr = "10.200.0.0/16"
    pub_cidrs = ["10.200.0.0/24", "10.200.1.0/24"]
     
}