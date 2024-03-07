resource "aws_s3_bucket" "polyglot-translation-bucket" {
  bucket = "polyglot-translation-bucket-us-west-2"
}

resource "aws_s3_object" "language-english" {
  bucket = aws_s3_bucket.polyglot-translation-bucket.id
  key    = "language-english/"
  acl      = "private"
  content_type = "application/x-directory"
}

resource "aws_s3_object" "language-spanish" {
  bucket = aws_s3_bucket.polyglot-translation-bucket.id
  key    = "language-spanish/"
  acl      = "private"
  content_type = "application/x-directory"
}