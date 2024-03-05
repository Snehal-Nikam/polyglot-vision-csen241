FROM python:3
WORKDIR /app
COPY . ./
RUN pip3 install -r requirements.txt && touch .env
RUN export FLASK_HOST=0.0.0.0 FLASK_PORT=8080
EXPOSE 8080
CMD [ "python", "./backend.py" ]
