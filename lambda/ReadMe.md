### Transcribe-lambda:

1. Create a lambda function for transcribe with Python3.8 runtime.
2. Give the lambda execution role AmazonTranscribeFullAccess and AmazonS3FullAccess in permissons.
3. Create a trigger to Amazon S3 input videos bucket with original-video/ as prefix and .mp4 as suffix.
4. Set the environment variable TRANSCRIBE_BUCKET in lambda configuration. This saves the json output of Amazon Transcribe in this bucket.
5. Input videos bucket: polyglot-input-videos-bucket
6. TRANSCRIBE_BUCKET: polyglot-transcribe-output-bucket


### Translate-lambda:

1. Create a lambda function for translate with Python 3.8 runtime.
2. GIve the lambda execution role the following permissions.
        TranslateFullAccess
        AmazonS3FullAccess 
3. Create a trigger to Amazon S3 transcribe output bucket with .json as the suffix.
4. Create an environment variable in lambda configurations to store the translated subtitles.
5. TRANSLATE_BUCKET: polyglot-translation-bucket-cc241

### Subtitles-lambda:

1. This is responsible for calling subtitle API as soon as translation job is done.
2. Give the lambda execution role the following permissions.
    AmazonEC2FullAccess 
    AmazonS3FullAccess
3. Create a S3 trigger to translation bucket with language-hindi/ as prefix and .vtt as suffix.
4. Create the following Environment variables.
5. TRANSLATE_BUCKET: polyglot-translation-bucket-cc241
6. VIDEOS_BUCKET: polyglot-input-videos-bucket
7. SUBTITLE_API: URL of subtitles API.

### Final-lambda

1. This lambda is responsible for storing the translated and subtitled video information and informing the user about the job completion.
2. The lambda execution role requires following permissions. AmazonDynamoDBFullAccess, AmazonS3ReadOnlyAccess and AmazonSESFullAccess
3. Create a S3 trigger to polyglot-input-videos-bucket with info as prefix and .json as suffix.
4. The following environment variables need to be created.
    VIDEOS_TABLE: Dynamo DB table to store the info
    SOURCE_EMAIL: Source email from which the notification needs to be sent.
