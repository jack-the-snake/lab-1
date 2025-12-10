terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.25.0"
    }
  }
}

provider "aws" {
  # Configuration options
}

variable "public-access" {
  type    = bool
  default = false
}

resource "aws_s3_bucket" "my-bucket" {
  bucket_prefix = "awsninja20-"
}

output "bucket_name" {
  value = aws_s3_bucket.my-bucket.bucket
}

resource "aws_s3_object" "object" {
  for_each = fileset(path.module, "messages/*")

  bucket = aws_s3_bucket.my-bucket.bucket
  key    = basename(each.key)
  source = each.key
}

resource "aws_s3_bucket_policy" "allow_public_access" {
  count      = var.public-access ? 1 : 0
  depends_on = [aws_s3_bucket_public_access_block.public_access]

  bucket = aws_s3_bucket.my-bucket.id
  policy = data.aws_iam_policy_document.allow_public_access.json
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  count = var.public-access ? 1 : 0

  bucket = aws_s3_bucket.my-bucket.id

  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false
}

data "aws_iam_policy_document" "allow_public_access" {
  statement {
    sid    = "PublicReadGetObject"
    effect = "Allow"
    principals {
      identifiers = ["*"]
      type        = "*"
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.my-bucket.arn,
      "${aws_s3_bucket.my-bucket.arn}/*",
    ]
  }
}
