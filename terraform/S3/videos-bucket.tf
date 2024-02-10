resource "aws_s3_bucket" "cc241-input-videos-bucket" {
  bucket = "cc241-input-videos-bucket"
}

resource "aws_s3_object" "original-video" {
  bucket = aws_s3_bucket.cc241-input-videos-bucket.id
  key    = "original-video/"
  content_type = "application/x-directory"
}

resource "aws_s3_object" "info" {
  bucket = aws_s3_bucket.cc241-input-videos-bucket.id
  key    = "info/"
  content_type = "application/x-directory"
}

resource "aws_s3_object" "subtitled-video" {
  bucket = aws_s3_bucket.cc241-input-videos-bucket.id
  key    = "subtitled-video/"
  content_type = "application/x-directory"
}

resource "aws_s3_bucket_policy" "bucket-policy" {
  bucket = aws_s3_bucket.cc241-input-videos-bucket.id
  policy = data.aws_iam_policy_document.bucket-policy.json
  depends_on=[data.aws_iam_policy_document.bucket-policy]
}
resource "aws_s3_bucket_acl" "cc241-input-videos-bucket" {
  bucket = aws_s3_bucket.cc241-input-videos-bucket.id
  acl    = "public-read"
  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership]
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.cc241-input-videos-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
  bucket = aws_s3_bucket.cc241-input-videos-bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
  depends_on = [aws_s3_bucket_public_access_block.example]
}


data "aws_iam_policy_document" "bucket-policy" {
  statement {
    sid       = "PublicRead"
    effect    = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
      "s3:GetObjectVersion"
    ]
    resources = [
       aws_s3_bucket.cc241-input-videos-bucket.arn,
      "${aws_s3_bucket.cc241-input-videos-bucket.arn}/*",
      "${aws_s3_bucket.cc241-input-videos-bucket.arn}/${aws_s3_object.subtitled-video.id}*"
    ]
  }
  depends_on = [aws_s3_bucket_public_access_block.example]
}