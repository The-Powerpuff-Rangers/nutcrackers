
from ultralytics import YOLO
import supervision as sv
import numpy as np
import cv2
import os
from flask import request, jsonify
import base64

model = YOLO("model/yolov8_v2.pt")

def detect(image):
    npimg = np.frombuffer(image, np.uint8)
    frame = cv2.imdecode(npimg, cv2.IMREAD_COLOR)
    result = model(frame, agnostic_nms=True)[0]

    return result

if __name__ == '__main__':
    image = cv2.imread("IMG_2292.jpg")
    # result = detect(image)[0]
    result = model(image)
    # print(results[0].boxes.data)
    box_annotator = sv.BoxAnnotator(
        thickness=3,
        color=(0, 255, 0),
    )

    # detections = sv.Detections.from_yolov8(result, box_annotator)


    # frame = box_annotator.annotate(image, detections)

    # cv2.imwrite("test_image_result.jpeg", frame)
    print(result)
