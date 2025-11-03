terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.0.0"
}

provider "aws" {
  region = "eu-north-1"
}

resource "random_id" "id" {
  byte_length = 4
}

# Step 1: Create S3 bucket
resource "aws_s3_bucket" "insecure_bucket" {
  bucket = "devsecops-demo-bucket-${random_id.id.hex}"

  tags = {
    Name = "devsecops-demo"
    Env  = "demo"
  }
}

# Step 2: Enable ACL usage (AWS now requires this separately)
resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.insecure_bucket.id

  rule {
    object_ownership = "ObjectWriter"
  }
}

# Step 3: Set intentionally insecure ACL
resource "aws_s3_bucket_acl" "insecure_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.example]
  bucket     = aws_s3_bucket.insecure_bucket.id
  acl        = "public-read"  # intentionally insecure for tfsec demo
}
