resource "aws_key_pair" "medingen_key" {
  key_name   = "medingen-key"
  public_key = file("${path.root}/data/medingen-key.pub")
}

resource "aws_instance" "server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  key_name               = aws_key_pair.medingen_key.key_name

  tags = {
    Name = "${var.env}-app-server"
  }
}
