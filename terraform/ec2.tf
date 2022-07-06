# EC2
resource "aws_instance" "ec2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  # the VPC subnet
  subnet_id = aws_subnet.main-public-subnet.id
  # the security group
  vpc_security_group_ids = [aws_security_group.inbound-outbound.id]
  # the public SSH key
  key_name = aws_key_pair.ssh-key-pair.key_name
  user_data = <<-EOF
    #!/bin/bash
    set -ex
    # Install docker
    apt update
    apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
    mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    apt-get update
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
    usermod -aG docker ubuntu
  EOF
  tags = {
    Tier = var.tier
    Name = "${var.project_name}-ec2-instance"
  }
}