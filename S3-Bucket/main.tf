resource "aws_s3_bucket" "reactapp" {
  bucket = "my-react-app-md"

  tags = {
    "Name" = "reactapp_S3"
  }
}

resource "aws_s3_bucket_website_configuration" "react_config" {
  bucket = aws_s3_bucket.reactapp.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_ownership_controls" "react_bucket_ownership" {
  bucket = aws_s3_bucket.reactapp.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "react_bucket_public_access" {
  bucket = aws_s3_bucket.reactapp.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "react_bucket_policy" {
  bucket = aws_s3_bucket.reactapp.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.reactapp.arn}/*"
      }
    ]
  })
}

#upload dist/ from the react app
resource "aws_s3_object" "react_files" {
  for_each = fileset("${path.module}/dist", "**") # Adjust this path ${path.module}

  bucket = aws_s3_bucket.reactapp.id
  key    = each.value
  source = "${path.module}/dist/${each.value}" # Upload from external directory of path ${path.module} 

  content_type = lookup({
    "html" = "text/html",
    "js"   = "application/javascript",
    "css"  = "text/css",
    "png"  = "image/png",
    "jpg"  = "image/jpeg",
    "svg"  = "image/svg+xml",
    "json" = "application/json"
  }, split(".", each.value)[length(split(".", each.value)) - 1], "application/octet-stream")
}

