from ultralytics import YOLO
import supervision as sv
import numpy as np
import cv2
import flask
import os
from flask import request, jsonify
import base64

# Initialize the Flask application
app = flask.Flask(__name__)

# Initialize the YOLO model
model = YOLO("model/yolov8m.pt")

def _decode(img: str) -> np.ndarray:
    """Decode the image from base64 format.
    Args: 
        img: The image in base64 format.
    Returns:
        The decoded image.
    """
    nparr = np.frombuffer(request.files["image"].read(), np.uint8)
    img = cv2.imdecode(nparr, cv2.IMREAD_COLOR)
    return img

def _encode(img: np.ndarray) -> str:
    """Encode the image to base64 format.
    
    Args:
        img: The image to be encoded.
    Returns:
        The encoded image.
    """
    _, buffer = cv2.imencode(".jpg", img)
    return base64.b64encode(buffer).decode("utf-8")

@app.route("/predict", methods=["POST"])
def predict():
    """Predict the bounding boxes of the input image.
    Returns:
        The image with bounding boxes.
    """
    # Decode the image
    img = _decode(request.files["image"])
    # Predict the bounding boxes
    result = model(img)[0]

    frame = None

    # Encode the image
    img = _encode(frame)
    return jsonify({"image": img})