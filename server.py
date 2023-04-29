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
model = YOLO("model/yolov8_v2.pt")


def _decode(img: str) -> np.ndarray:
    """Decode the image from base64 format.
    Args: 
        img: The image in base64 format.
    Returns:
        The decoded image.
    """

    decodedData = base64.b64decode((img))
    return cv2.imdecode(np.frombuffer(decodedData, np.uint8), cv2.IMREAD_COLOR)


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
    data = request.get_json()
    img = _decode(data['image'])

    # Predict the bounding boxes
    result = model(img, agnostic_nms=True)[0]

    box_annotator = sv.BoxAnnotator(
        text_thickness=2,
        thickness=2,
        text_scale=1
    )

    detections = sv.Detections.from_yolov8(result)

    frame = box_annotator.annotate(
        scene=img, detections=detections)

    # Encode the image
    img_base64 = _encode(frame)

    typeA = typeB = typeC = 0

    for box in result.boxes:
        if box.cls == 0:
            typeA += 1
        elif box.cls == 1:
            typeB += 1
        elif box.cls == 2:
            typeC += 1

    context = {
        "image": img_base64,
        "data": [
            {
                "label": "Type A",
                "count": typeA
            },
            {
                "label": "Type B",
                "count": typeB
            },
            {
                "label": "Type C",
                "count": typeC
            },
        ]
    }
    return context

if __name__ == "__main__":
    app.run(debug=True, host='10.100.40.135')