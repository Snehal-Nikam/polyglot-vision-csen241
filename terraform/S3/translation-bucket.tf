resource "aws_s3_bucket" "cc241-translation-bucket" {
  bucket = "cc241-translation-bucket"
}

resource "aws_s3_object" "language-english" {
  bucket = aws_s3_bucket.cc241-translation-bucket.id
  key    = "language-english/"
  acl      = "private"
  content_type = "application/x-directory"
}

resource "aws_s3_object" "language-hindi" {
  bucket = aws_s3_bucket.cc241-translation-bucket.id
  key    = "language-hindi/"
  acl      = "private"
  content_type = "application/x-directory"
}