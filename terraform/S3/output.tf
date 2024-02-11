output "polyglot-transcribe-output-bucket" {
  value = aws_s3_bucket.polyglot-transcribe-output-bucket.id
}

output "polyglot-input-videos-bucket" {
  value = aws_s3_bucket.polyglot-input-videos-bucket.id
}

output "polyglot-translation-bucket" {
  value = aws_s3_bucket.polyglot-translation-bucket-cc241.id
}