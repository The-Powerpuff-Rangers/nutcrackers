from ultralytics import YOLO
import supervision as sv
import numpy as np
import cv2
import argparse
import flask
import os
from flask import request, jsonify
import base64

ZONE_POLYGON = np.array([
    [0, 0],
    [0.5, 0],
    [0.5, 1],
    [0, 1]
])

model = YOLO("model/yolov8m.pt")

app = flask.Flask(__name__)

@app.route('/', methods=['GET'])
def home():
    return "<h1>YOLOv8</h1><p>YOLOv8 API.</p>"

@app.route('/api/v1/detect', methods=['POST'])
def detect():
    data = request.get_json()
    image = data['image']
    image = base64.b64decode(image)
    npimg = np.frombuffer(image, np.uint8)
    frame = cv2.imdecode(npimg, cv2.IMREAD_COLOR)
    result = model(frame, agnostic_nms=True)[0]

    return print(results[0].boxes.boxes)
    
if __name__ == '__main__':
    app.run(debug=True, host='192.168.0.102')
