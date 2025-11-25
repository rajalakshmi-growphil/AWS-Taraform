# 1) init
terraform init

# 2) create a plan file (binary)
terraform plan -out=tfplan

terraform plan -out=tfplan -var="db_password=Medingen@2025"

# 3) human-readable plan (plain text)
terraform show -no-color tfplan > full-plan.txt

# 4) structured plan (json) — best for filtering
terraform show -json tfplan > full-plan.json

<!-- terraform validate -->

terraform validate

terraform providers

tree /F

terraform plan -no-color -target module.s3 -var "db_password=Medingen@2025" -out s3.tfplan | Out-File -Encoding utf8 s3-plan.txt
terraform plan -no-color -target module.db -var "db_password=Medingen@2025" -out db.tfplan | Out-File -Encoding utf8 db-plan.txt
terraform plan -no-color -target module.vpc -var "db_password=Medingen@2025" -out vpc.tfplan | Out-File -Encoding utf8 vpc-plan.txt
