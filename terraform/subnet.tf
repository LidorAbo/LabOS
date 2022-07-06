# Public subnets
resource "aws_subnet" "main-public-subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, 0 )
  map_public_ip_on_launch = "true"
  tags = {
    Name = "${var.project_name}-public-subnet"
    Tier = var.tier
  }
}