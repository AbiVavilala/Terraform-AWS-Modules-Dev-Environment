module "FlaskVPC" {
source    = "./modules/VPC"
vpc_cidr  = "10.200.0.0/16"
pub_cidrs = ["10.200.0.0/24", "10.200.1.0/24"]
pri_cidrs = ["10.200.2.0/24", "10.200.3.0/24"]

}

module "Flaskec2" {
  source = "./modules/ec2"
  ami_id = "ami-0e812285fd54f7620"
  subnet_id = module.FlaskVPC.pub_subnet_id[0]
  flask_security_group_id = module.FlaskVPC.Flask_Securitygroup
  flask_userdata = file("userdata.tpl")
}