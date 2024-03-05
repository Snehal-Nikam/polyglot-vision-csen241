FROM python:3
RUN mkdir -p /usr/local/bin/ffmpeg/ffmpeg-release-amd64-static && wget -P /usr/local/bin/ffmpeg/ https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz && tar xvf /usr/local/bin/ffmpeg/ffmpeg-release-amd64-static.tar.xz -C /usr/local/bin/ffmpeg/ffmpeg-release-amd64-static --strip-components 1 && mv /usr/local/bin/ffmpeg/ffmpeg-release-amd64-static/ffmpeg /usr/local/bin/ffmpeg/ && ln -s /usr/local/bin/ffmpeg/ffmpeg /usr/bin/ffmpeg
RUN  echo -e "<?xml version="1.0" encoding="UTF-8"?>\n\
<?xml version="1.0" encoding="UTF-8"?>\n\
<!DOCTYPE policymap [\n\
<!ELEMENT policymap (policy)+>\n\
<!ELEMENT policy (#PCDATA)>\n\
<!ATTLIST policy domain (delegate|coder|filter|path|resource) #IMPLIED>\n\
<!ATTLIST policy name CDATA #IMPLIED>\n\
<!ATTLIST policy rights CDATA #IMPLIED>\n\
<!ATTLIST policy pattern CDATA #IMPLIED>\n\
<!ATTLIST policy value CDATA #IMPLIED>\n\
]>\n\
<policymap>\n\
</policymap>" > /etc/ImageMagick-6/policy.xml
WORKDIR /app
COPY . ./
RUN pip3 install -r requirements.txt
RUN export FLASK_HOST=0.0.0.0 FLASK_PORT=8081
CMD [ "python", "./main.py" ]
