resource "aws_instance" "Flaskec2" {
 ami = var.ami_id
 instance_type = var.instance_type
 subnet_id = var.subnet_id 
 security_groups = [var.flask_security_group_id]
 associate_public_ip_address = true
 user_data = var.flask_userdata
 }