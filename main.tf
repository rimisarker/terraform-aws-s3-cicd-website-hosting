terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

# 1. Create a unique S3 Bucket
resource "aws_s3_bucket" "website_bucket" {
  bucket        = "my-unique-nature-gallery-2026" 
  force_destroy = true # <--- আপনার কোডের এই ১ নম্বর সেকশনে এটি যোগ করা হয়েছে
}

# 2. Configure S3 Bucket Static Website Hosting
resource "aws_s3_bucket_website_configuration" "hosting" {
  bucket = aws_s3_bucket.website_bucket.id

  index_document {
    suffix = "index.html"
  }
}

# 3. Disable Public Access Block
resource "aws_s3_bucket_public_access_block" "public_block" {
  bucket = aws_s3_bucket.website_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# 4. Apply Public Read Bucket Policy
resource "aws_s3_bucket_policy" "public_policy" {
  bucket = aws_s3_bucket.website_bucket.id
  depends_on = [aws_s3_bucket_public_access_block.public_block]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.website_bucket.arn}/*"
      }
    ]
  })
}

# 5. Output the live website URL
output "website_url" {
  value = aws_s3_bucket_website_configuration.hosting.website_endpoint
}