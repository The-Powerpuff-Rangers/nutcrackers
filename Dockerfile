FROM --platform=arm64 python:3.9.16-alpine3.16

RUN pip install --upgrade pip \
    -r requirements/prod.txt

RUN rm -rf requirements