#!/bin/bash

sudo yum update -y
sudo yum install git -y
git clone https://github.com/Snehal-Nikam/polyglot-vision-csen241.git
cd polyglot-vision-csen241/subtitle-api
sudo bash install_ffmpeg_amazonlinux.sh
sudo bash install_imagemagick_amazonlinux.sh
sudo yum install python3 -y
sudo python3 -m pip install -r requirements.txt
export API_FLASK_HOST=0.0.0.0
export API_FLASK_PORT=8081
python3 main.py