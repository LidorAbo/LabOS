# Security group
locals {
  ssh_port = 22
  http_port = 80
}
resource "aws_security_group" "inbound-outbound" {
  vpc_id      = aws_vpc.main.id
  name        = "allow-ssh-and-http-port-egress-all"
  description = "security group that allows ssh and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = local.ssh_port
    to_port     = local.ssh_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = local.http_port
    protocol  = "tcp"
    to_port   = local.http_port
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Tier = var.tier
  }
}