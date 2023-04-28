
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
    result = model(image)[0]
    # print(results[0].boxes.data)
    box_annotator = sv.BoxAnnotator(
        text_thickness=2,
        thickness=2,
        text_scale=1
    )

    detections = sv.Detections.from_yolov8(result)
    print(detections)

    labels = [f"{model.model.names[class_id]} {conf:.2f}" for _, conf, class_id, _ in detections]

    frame = box_annotator.annotate(
        scene=image, detections=detections)

    # frame = box_annotator.annotate(image, detections)

    cv2.imwrite("test_image_result.jpeg", frame)
    print(result.boxes[0].conf)
    print(result.boxes[0].cls)
    print(result.boxes[0].xywh)
