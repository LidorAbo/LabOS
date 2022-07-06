resource "aws_key_pair" "ssh-key-pair" {
  key_name   = "LabOS"
  public_key = file(var.path_to_public_key)
}