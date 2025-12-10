provider "aws" {
  # Configuration options
  ignore_tags {
    keys = var.tags-to-ignore
  }
}

resource "aws_s3_bucket" "my-bucket" {
  bucket_prefix = "awsninja20-"
}

resource "aws_s3_object" "object" {
  for_each = fileset(path.module, "messages/*")

  bucket = aws_s3_bucket.my-bucket.bucket
  key    = basename(each.key)
  source = each.key
}

