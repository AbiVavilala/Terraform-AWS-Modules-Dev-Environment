output "vpc_id" {
  value = aws_vpc.Flask_VPC.id
}

output "pub_subnet_id" {
 value = aws_subnet.Public_subnet.*.id
}  

output "pri_subnet_id" {
 value = aws_subnet.Private_subnet.*.id
}  

output "Flask_Securitygroup" {
    value = aws_security_group.Flask_Securitygroup.id
  
}