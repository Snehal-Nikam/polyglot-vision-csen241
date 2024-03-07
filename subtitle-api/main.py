import os
from flask_cors import CORS
from flask import Flask, jsonify, request, Response
from subtitle import *
import json
import boto3

__api_flask_host = os.environ.get('API_FLASK_HOST') if os.environ.get('API_FLASK_HOST') else '0.0.0.0'
__api_flask_port = os.environ.get('API_FLASK_PORT') if os.environ.get('API_FLASK_PORT') else '8081'

app = Flask(__name__)
CORS(app)

s3_client = boto3.client('s3')

if not os.path.exists('temp'):
    os.mkdir('./temp')
    os.mkdir('./temp/language-spanish')
    os.mkdir('./temp/language-english')
    os.mkdir('./temp/original-video')
    os.mkdir('./temp/subtitled')
    os.mkdir("./temp/job-info")


def download_file_from_s3(bucketPath, fileName):

    bucket = bucketPath.split('/')[0]
    extension = bucketPath.split('.')[1]

    extractedFileName = "{}/{}.{}".format(bucketPath.split('/')[1], fileName, extension)
    filePath = './temp/{}'.format(extractedFileName)

    s3_client.download_file(bucket, extractedFileName, filePath)

    return filePath

def store_file_to_s3(bucketPath, fileName, path):
    bucketName = bucketPath.split('/')[0]
    extension = bucketPath.split('.')[1]

    extractedFileName = "{}/{}.{}".format(bucketPath.split('/')[1], fileName, extension)

    s3_client.upload_file(path, bucketName, extractedFileName)

def start_job(fileName, data, originalPath, subtitlePathHI, subtitlePathEN, outputPath):
    videoSubtitles = video_subtitle()

    job_info = videoSubtitles.create_subtitled_video(fileName, originalPath, subtitlePathHI, subtitlePathEN, outputPath)

    with open('./temp/job-info/{}.json'.format(fileName), 'w') as outfile:
        json.dump(job_info, outfile)

    store_file_to_s3(data['subtitled_video'], fileName, outputPath)
    store_file_to_s3(data['job_info'], fileName, './temp/job-info/{}.json'.format(fileName))


@app.route('/', methods=['GET'])
def health():
    return jsonify("Healthy!"), 200


#API for combining the transcribe result for video and save the result into bucket
@app.route('/video', methods=['POST'])
def startProcessing():
    print("Process start!!")
    if request.method == 'POST':
        data = request.get_json()
        print('data : ', data)
        fileName = data['original_video'].split('.')[0].split('/')[-1]

        originalPath = download_file_from_s3(data['original_video'], fileName)
        subtitlePathHI = download_file_from_s3(data['translation'], fileName)
        subtitlePathEN = download_file_from_s3(data['transcription'], fileName)
        outputPath = './temp/subtitled/{}.mp4'.format(fileName)

        start_job(fileName, data, originalPath, subtitlePathHI, subtitlePathEN, outputPath)
        return jsonify("Succesfully started job"), 201
    else:
        return jsonify(""), 400


if __name__ == '__main__':
    app.run(host=__api_flask_host, port=__api_flask_port)