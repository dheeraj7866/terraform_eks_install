resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "vpc-${var.environment}"
  }
}

resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-${count.index + 1}-${var.environment}"
  }
}

# resource "aws_subnet" "private" {
#   count             = length(var.private_subnet_cidrs)
#   vpc_id            = aws_vpc.this.id
#   cidr_block        = var.private_subnet_cidrs[count.index]
#   availability_zone = element(var.availability_zones, count.index)
#   tags = {
#     Name = "private-subnet-${count.index + 1}-${var.environment}"
#   }
# }

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "igw-${var.environment}"
  }
}

# resource "aws_nat_gateway" "this" {
#   allocation_id = aws_eip.this.id
#   subnet_id     = element(aws_subnet.public.*.id, 0)
#   tags = {
#     Name = "nat-gateway-${var.environment}"
#   }
# }

# resource "aws_eip" "this" {
#   domain = "vpc"
# }

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "public-rt-${var.environment}"
  }
}

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public.*.id)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

# resource "aws_route_table" "private" {
#   vpc_id = aws_vpc.this.id
#   tags = {
#     Name = "private-rt-${var.environment}"
#   }
# }

# resource "aws_route" "private_internet_access" {
#   route_table_id         = aws_route_table.private.id
#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id         = aws_nat_gateway.this.id
# }

# resource "aws_route_table_association" "private" {
#   count          = length(aws_subnet.private.*.id)
#   subnet_id      = element(aws_subnet.private.*.id, count.index)
#   route_table_id = aws_route_table.private.id
# }
