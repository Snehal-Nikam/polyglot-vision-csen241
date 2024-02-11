Create a lambda function for transcribe with Python3.8 runtime.
Give the lambda execution role AmazonTranscribeFullAccess and AmazonS3FullAccess in permissons.
Create a trigger to Amazon S3 input bucket with original-video/ as prefix and .mp4 as suffix.
Set the environment variable TRANSCRIBE_BUCKET in lambda configuration. This saves the json output of Amazon Transcribe in this bucket.
Input videos bucket: cc241-input-videos-bucket
TRANSCRIBE_BUCKET: cc241-transcribe-output-bucket