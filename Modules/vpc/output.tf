output "vpc_id" {
 description = "VPC ID"
 value = aws_vpc.main.id
}
output "public_subnet_ids" {
 description = "List of public subnet IDs"
 value = aws_subnet.public[*].id
}
output "private_subnet_ids" {
 description = "List of private subnet IDs"
 value = aws_subnet.private[*].id
}
output "internet_gateway_id" {
 description = "Internet Gateway ID"
 value = aws_internet_gateway.main.id
}
output "nat_gateway_ids" {
 description = "List of NAT Gateway IDs"
 value = aws_nat_gateway.main[*].id
}
output "public_route_table_id" {
 description = "Public Route Table ID"
 value = aws_route_table.public.id
}
output "private_route_table_ids" {
 description = "List of Private Route Table IDs"
 value = aws_route_table.private[*].id
}
output "eip_ids" {
 description = "List of EIP IDs for NAT Gateways"
 value = aws_eip.nat[*].id
}
output "cluster_name" {
 description = "Name of the EKS cluster"
 value = var.cluster_name
}
output "vpc_cidr" {
 description = "CIDR block for the VPC"
 value = var.vpc_cidr
}
output "availability_zones" {
 description = "List of availability zones"
 value = var.availability_zones
}
output "private_subnet_cidrs" {
 description = "CIDR blocks for private subnets"
 value = var.private_subnet_cidrs
}
output "public_subnet_cidrs" {
 description = "CIDR blocks for public subnets"
 value = var.public_subnet_cidrs
}
output "vpc_tags" {
 description = "Tags applied to the VPC"
 value = aws_vpc.main.tags
}
output "subnet_tags" {
 description = "Tags applied to the subnets"
 value = {
   public = aws_subnet.public[*].tags
   private = aws_subnet.private[*].tags
 }
}
output "internet_gateway_tags" {
 description = "Tags applied to the Internet Gateway"
 value = aws_internet_gateway.main.tags
}
output "nat_gateway_tags" {
 description = "Tags applied to the NAT Gateways"
 value = aws_nat_gateway.main[*].tags
}       