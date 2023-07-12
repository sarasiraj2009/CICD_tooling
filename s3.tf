# Provides an S3 bucket resource
resource "aws_s3_bucket" "example" {
  bucket = var.bucketName
}

# Provides a resource to manage S3 Bucket Ownership Controls.
resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.example.id
  
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Manages S3 bucket-level Public Access Block configuration
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.example.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Provides an S3 bucket ACL resource
resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.example,
  ]

  bucket = aws_s3_bucket.example.id
  acl    = "public-read"
}

#Configures the S3 bucket as a static website 
resource "aws_s3_bucket_website_configuration" "example-config" {
  bucket = aws_s3_bucket.example.bucket
  index_document {
    suffix = "index.html"
  }
}

#Attaches a policy to the S3 bucket resource
resource "aws_s3_bucket_policy" "example-policy" {
  bucket = aws_s3_bucket.example.id
  policy = templatefile("s3-policy.json", { bucket = var.bucketName })
}

resource "aws_s3_object" "example-index" {
  bucket = aws_s3_bucket.example.id
  key    = "index.html"
  source = "index.html"
  acl    = "public-read"
}