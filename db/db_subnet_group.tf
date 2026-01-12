resource "aws_db_subnet_group" "main" {
  name       = "medingen-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = { Name = "medingen-db-subnet-group" }
}
