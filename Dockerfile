FROM python:3.9.16

WORKDIR /app

COPY . /app

RUN apt-get update && apt-get install ffmpeg libsm6 libxext6  -y

RUN pip install -r requirements/prod.txt

RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu

EXPOSE 5000

ENTRYPOINT ["python", "server.py"]