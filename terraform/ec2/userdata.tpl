#!/bin/bash
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
##################################### USER  DATA START ############################################

yum update -y
yum install git python3 python3-pip npm net-tools vim -y
npm install --global yarn
yarn global add @quasar/cli
yarn global add cors
git clone https://github.com/Snehal-Nikam/polyglot-vision-csen241
cd polyglot-vision-csen241/backend
pip3 install -r requirements.txt
export FLASK_HOST=0.0.0.0
export FLASK_PORT=8080
cd /usr/local/bin
mkdir ffmpeg
cd ffmpeg
wget https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz
mkdir ffmpeg-release-amd64-static
tar xvf ffmpeg-release-amd64-static.tar.xz -C ffmpeg-release-amd64-static --strip-components 1
mv ffmpeg-release-amd64-static/ffmpeg .

ln -s /usr/local/bin/ffmpeg/ffmpeg /usr/bin/ffmpeg

yum install ImageMagick ImageMagick-devel -y
cat << EOF > /etc/ImageMagick-6/policy.xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE policymap [
<!ELEMENT policymap (policy)+>
<!ELEMENT policy (#PCDATA)>
<!ATTLIST policy domain (delegate|coder|filter|path|resource) #IMPLIED>
<!ATTLIST policy name CDATA #IMPLIED>
<!ATTLIST policy rights CDATA #IMPLIED>
<!ATTLIST policy pattern CDATA #IMPLIED>
<!ATTLIST policy value CDATA #IMPLIED>
]>
<policymap>
</policymap>
EOF

cd /polyglot-vision-csen241/subtitle-api
sudo pip3 install -r requirements.txt
cd /polyglot-vision-csen241/frontend
yarn
yarn run lint --fix
quasar build

##################################### USER DATA END #######################################
) 2>&1)  | logit
