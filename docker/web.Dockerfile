FROM python:3.8-slim-buster
ENV app_name=app.py
EXPOSE 8080
COPY requirements.txt $app_name ./
RUN pip3 install -r requirements.txt 2> /dev/null
CMD python3 $app_name