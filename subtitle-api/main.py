import os
import flask_cors as CORS
from flask import Flask, jsonify, request, Response
from subtitle import *
import json
import boto3

__api_flask_host = os.environ.get('API_FLASK_HOST')
__api_flask_port = os.environ.get('API_FLASK_PORT')

app = Flask(__name__)
CORS(app)

s3_client = boto3.client('s3')

if not os.path.exists('temp'):
    os.mkdir('./temp')
    os.mkdir('./temp/hindi')
    os.mkdir('./temp/english')
    os.mkdir('./temp/original')
    os.mkdir('./temp/subtitled')
    os.mkdir("./temp/job-info")

def start_job(fileName, data, originalPath, subtitlePathHI, subtitlePathEN, outputPath):
    videoSubtitles = video_subtitle()

    job_info = videoSubtitles.create_subtitled_video(originalPath, subtitlePathHI, subtitlePathEN)

    with open('./temp/job-info/{}.json'.format(fileName), 'w') as outfile:
        json.dump(job_info, outfile)

    #Save Subtitle video to bucket
    bucket = data['subtitled_video'].split('/')[0]
    extension = data['subtitled_video'].split('.')[1]
    tempfileNameS3 = "{}/{}.{}".format(data['subtitled_video'].split('/')[1], fileName, extension)
    s3_client.upload_file(outputPath, bucket, tempfileNameS3)


#API for combining the transcribe result for video and save the result into bucket
@app.route('/video', methods=['POST'])
def startProcessing():
    print("Process start!!")
    if request.method == 'POST':
        data = request.get_json()
        print('data : ', data)
    else:
        return jsonify(""), 400


if __name__ == '__main__':
    app.run(host=__api_flask_host, port=__api_flask_port)