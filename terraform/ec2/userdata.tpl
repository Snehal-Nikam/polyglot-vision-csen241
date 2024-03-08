#!/bin/sh
logit() {
   while read LINE
   do
      LOGFILE=/var/log/user-data.log
      STAMP=$(date +"%Y-%m-%d %H:%M:%S")
      echo "$STAMP       $LINE" >> $LOGFILE
   done

}

set -x
((

#yum update -qy
#yum install git python3 python3-pip npm net-tools vim -qy
#npm install --global yarn
#yarn global add @quasar/cli
#yarn global add cors

git clone https://github.com/Snehal-Nikam/polyglot-vision-csen241 ~/polyglot-vision-csen241
cd ~/polyglot-vision-csen241/backend
pip3 install -r requirements.txt

#mkdir -p /usr/local/bin/ffmpeg/ffmpeg-release-amd64-static
#wget -P /usr/local/bin/ffmpeg/ https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz
#tar -xvf /usr/local/bin/ffmpeg/ffmpeg-release-amd64-static.tar.xz -C /usr/local/bin/ffmpeg/ffmpeg-release-amd64-static --strip-components 1
#mv /usr/local/bin/ffmpeg/ffmpeg-release-amd64-static/ffmpeg /usr/local/bin/ffmpeg/
#ln -s /usr/local/bin/ffmpeg/ffmpeg /usr/bin/ffmpeg
#yum install ImageMagick ImageMagick-devel -y
#echo '<?xml version="1.0" encoding="UTF-8"?>
#<!DOCTYPE policymap [
#<!ELEMENT policymap (policy)+>
#<!ELEMENT policy (#PCDATA)>
#<!ATTLIST policy domain (delegate|coder|filter|path|resource) #IMPLIED>
#<!ATTLIST policy name CDATA #IMPLIED>
#<!ATTLIST policy rights CDATA #IMPLIED>
#<!ATTLIST policy pattern CDATA #IMPLIED>
#<!ATTLIST policy value CDATA #IMPLIED>
#]>
#<policymap>
#</policymap>' > /etc/ImageMagick-6/policy.xml

cd ~/polyglot-vision-csen241/subtitle-api
sudo pip3 install -r requirements.txt
cd ~/polyglot-vision-csen241/frontend
yarn
yarn run lint --fix
python3 /root/get_variables.py
cp /root/backend.env ~/polyglot-vision-csen241/backend/.env
cp /root/frontend.env ~/polyglot-vision-csen241/frontend/.env
cp /root/subtitle.env ~/polyglot-vision-csen241/subtitle-api/.env
quasar build

) 2>&1)  | logit
