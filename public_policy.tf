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
