module "vpc" {
  source = "./vpc"

  vpc_cidr              = var.vpc_cidr
  azs                   = var.azs
  public_subnets_cidrs  = var.public_subnets_cidrs
  private_subnets_cidrs = var.private_subnets_cidrs
  env                   = var.env
}

module "s3" {
  source = "./s3"

  bucket_names = var.bucket_names
  env          = var.env
}

module "db" {
  source = "./db"

  vpc_id                   = module.vpc.vpc_id
  private_subnet_ids       = module.vpc.private_subnet_ids
  db_username              = var.db_username
  db_password              = var.db_password
  db_name                  = var.db_name
  db_engine_version        = var.db_engine_version
  db_instance_class        = var.db_instance_class
  db_allocated_storage     = var.db_allocated_storage
  db_max_allocated_storage = var.db_max_allocated_storage
  db_allowed_cidrs         = [module.vpc.vpc_cidr]
  env                      = var.env
}
module "route53" {
  source = "./route53"

  zone_name = "medingen.in."

  records = [
    # A Record (CloudFront)
    {
      name = "medingen.in."
      type = "A"
      alias = {
        name                   = "des8ne135n583.cloudfront.net."
        zone_id                = "Z2FDTNDATAQYW2"
        evaluate_target_health = false
      }
    },

    # AAAA Record (CloudFront)
    {
      name = "medingen.in."
      type = "AAAA"
      alias = {
        name                   = "des8ne135n583.cloudfront.net."
        zone_id                = "Z2FDTNDATAQYW2"
        evaluate_target_health = false
      }
    },

    # MX records
    {
      name    = "medingen.in."
      type    = "MX"
      ttl     = 300
      records = [
        "0 smtp.secureserver.net",
        "10 mailstore1.secureserver.net"
      ]
    },

    # SRV
    {
      name    = "medingen.in."
      type    = "SRV"
      ttl     = 300
      records = ["100 1 443 autodiscover.secureserver.net"]
    },

    # TXT — FIXED (no double-quotes)
    {
      name    = "medingen.in."
      type    = "TXT"
      ttl     = 300
      records = [
        "D6663451",
        "v=spf1 include:secureserver.net include:zcsend.in -all",
        "google-site-verification=G8Deyr5tOp22CfGSwDPP0Fx7aLjnaqysxA2EcYPPo7k"
      ]
    },

    # TXT — escaped name (DKIM)
    {
      name    = "\\100.medingen.in."
      type    = "TXT"
      ttl     = 3600
      records = ["v=spf1 include:secureserver.net -all"]
    },

    # ACM validation (old) — optional: REMOVE if Terraform creates new ones automatically
    {
      name    = "_30d7256e6919ac9042d6d40b959dcb98.medingen.in."
      type    = "CNAME"
      ttl     = 300
      records = [
        "_d14234aa5f37f1fc94bff1884c4c5b9d.djqtsrsxkq.acm-validations.aws."
      ]
    },

    # DMARC TXT (fixed)
    {
      name    = "_dmarc.medingen.in."
      type    = "TXT"
      ttl     = 300
      records = [
        "v=DMARC1; p=quarantine; rua=mailto:you@example.com"
      ]
    },

    # DKIM record (fixed)
    {
      name    = "151034._domainkey.medingen.in."
      type    = "TXT"
      ttl     = 300
      records = [
        "k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC5GjQC6nTni/5xNotye8YaWgl2zC/SdDfUy6DmJKFFc0qTz1sYbdSSyWjp9tdAvXxHlljd8SiXtgoPbOQAR8Wqw2MK/pTm5AFAcUgzuVr9xT2llsEoM9j9uShXIDElnkqxAQZMzQkayrhtYFORWg4G9DIRZxfWiLz7I5S1Fr6sRQIDAQAB"
      ]
    },

    # Email CNAME
    {
      name    = "email.medingen.in."
      type    = "CNAME"
      ttl     = 300
      records = ["email.secureserver.net."]
    },

    # WWW → CloudFront
    {
      name    = "www.medingen.in."
      type    = "CNAME"
      ttl     = 300
      records = ["des8ne135n583.cloudfront.net."]
    },

    # ACM validation (www) — optional: REMOVE if using Terraform ACM module
    {
      name    = "_c78bc1960e89fed75039f850418a3c09.www.medingen.in."
      type    = "CNAME"
      ttl     = 300
      records = [
        "_b2a66717acdddeff496a9ac1e8465010.xlfgrmvvlj.acm-validations.aws."
      ]
    }
  ]
}


module "acm" {
  source       = "./acm"
  domain_name  = "medingen.in"
  zone_id      = module.route53.zone_id

  subject_alternative_names = [
    "www.medingen.in"
  ]
}


resource "aws_security_group" "ec2_sg" {
  name   = "ec2-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "ec2" {
  source             = "./ec2"
  subnet_id          = module.vpc.public_subnet_ids[0]
  security_group_ids = [aws_security_group.ec2_sg.id]
  instance_type      = "t3.micro"
  ami_id             = "ami-0f58b397bc5f1bf1f"
  key_name           = "medingen-key"
  env                = var.env
}

module "cloudfront" {
  source          = "./cloudfront"
  domain_name     = "medingen.in"
  certificate_arn = module.acm.certificate_arn
  s3_bucket       = module.s3.bucket_names[0]
}

module "lambda_api" {
  source      = "./lambda_api"
  lambda_name = "medingen-api"
  zip_path    = "lambda.zip"
  env         = var.env
}
