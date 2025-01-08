output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "IDs of public subnets"
  value       = aws_subnet.public.*.id
}

# output "private_subnet_ids" {
#   description = "IDs of private subnets"
#   value       = aws_subnet.private.*.id
# }

# output "nat_gateway_id" {
#   description = "ID of the NAT gateway"
#   value       = aws_nat_gateway.this.id
# }
