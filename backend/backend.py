from flask import Flask, request, jsonify
from flask_cors import CORS
import os
from s3_helpers import upload_to_s3
from dynamo_helpers import save_record_to_dynamodb, get_records_by_key
from cognito_user_auth import is_valid_user
import json

from dotenv import main
main.load_dotenv()

app = Flask(__name__)
CORS(app)


s3_bucket = os.environ.get('VIDEOS_BUCKET')
VIDEOS_TABLE = os.environ.get('VIDEOS_TABLE')
FLASK_HOST = os.environ.get('FLASK_HOST')
FLASK_PORT = os.environ.get('FLASK_PORT')
USER_POOL_ID = os.environ.get('USER_POOL_ID')

# post videos to s3 for a user
@app.route('/send', methods=['POST'])
def send_videos_to_s3():
   
    user_id = request.form.get('user_id')
    user_email = request.form.get('user_email')
    file_name = request.form.get('file_name')
    file_stream = request.files.get('file')

    if not is_valid_user(USER_POOL_ID, user_id):
        return jsonify("UserNotFound"), 401

    video_id = upload_to_s3(user_id, file_name, file_stream, s3_bucket, 'original-video')
    video_info = {
        "video_id": {"S": video_id},
        "user_id": {"S": user_id},
        "user_email": {"S": user_email},
        "video_name": {"S": file_name},
        "finished": {"BOOL": False},
    }
    save_record_to_dynamodb(
        VIDEOS_TABLE, video_info,
        'video_id', {'S': video_info['video_id']['S']}
    )

    return jsonify("Job started!"), 200


# get all the videos from a user
@app.route('/list', methods=['GET'])
def list_videos_from_user():
    
    user_id = request.args.get('id')

    if not is_valid_user(USER_POOL_ID, user_id):
        return jsonify("UserNotFound"), 401

    records = get_records_by_key(VIDEOS_TABLE, 'user_id', user_id)
    video_list = []
    if records:
        for record in records:
            info = dict()
            for key, value in record.records():
                info[key] = str(value)
            video_list.append(info)
    return jsonify(video_list), 200

# checks the health
@app.route('/', methods=['GET'])
def check_health():
    return json.dumps("Healthy!")


if __name__ == '__main__':
    app.run(host=FLASK_HOST, port=FLASK_PORT)