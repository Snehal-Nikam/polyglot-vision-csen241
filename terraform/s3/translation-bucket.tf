resource "aws_s3_bucket" "polyglot-translation-bucket-cc241" {
  bucket = "polyglot-translation-bucket-cc241"
}

resource "aws_s3_object" "language-english" {
  bucket = aws_s3_bucket.polyglot-translation-bucket-cc241.id
  key    = "language-english/"
  acl      = "private"
  content_type = "application/x-directory"
}

resource "aws_s3_object" "language-hindi" {
  bucket = aws_s3_bucket.polyglot-translation-bucket-cc241.id
  key    = "language-hindi/"
  acl      = "private"
  content_type = "application/x-directory"
}