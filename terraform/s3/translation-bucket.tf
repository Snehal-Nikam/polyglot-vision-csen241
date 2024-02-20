resource "aws_s3_bucket" "polyglot-translation-bucket" {
  bucket = "polyglot-translation-bucket"
}

resource "aws_s3_object" "language-english" {
  bucket = aws_s3_bucket.polyglot-translation-bucket.id
  key    = "language-english/"
  acl      = "private"
  content_type = "application/x-directory"
}

resource "aws_s3_object" "language-hindi" {
  bucket = aws_s3_bucket.polyglot-translation-bucket.id
  key    = "language-hindi/"
  acl      = "private"
  content_type = "application/x-directory"
}