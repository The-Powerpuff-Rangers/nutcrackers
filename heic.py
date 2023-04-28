import os
from PIL import Image

def heic_to_jpg(path):
    print(path)

for file in os.listdir("dataset"):
    if not file.startswith("."):
        for img in os.listdir(f"dataset/{file}"):
            if img.endswith(".HEIC"):
                os.remove(f"dataset/{file}/{img}")
                print(f"[PROCESSED] dataset/{file}/{img}")
        
        