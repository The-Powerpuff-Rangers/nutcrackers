> First Prize winner at Yamaha Explore AI 2.0

<center>
  
 ![image](https://github.com/The-Powerpuff-Rangers/nutcrackers/assets/74452705/4304ab01-9577-4223-831e-0edb1e3ac12b)


Nutcracker is a object detection and counting app
  
 ![](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
 ![](https://img.shields.io/badge/Flask-000000?style=for-the-badge&logo=flask&logoColor=white)
 ![](https://img.shields.io/badge/TensorFlow-FF6F00?style=for-the-badge&logo=tensorflow&logoColor=white)
 ![](https://img.shields.io/badge/Docker-2CA5E0?style=for-the-badge&logo=docker&logoColor=white)
 ![](https://img.shields.io/badge/Figma-F24E1E?style=for-the-badge&logo=figma&logoColor=white)
 ![](https://img.shields.io/badge/Python-FFD43B?style=for-the-badge&logo=python&logoColor=blue)
 ![](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
 
  
## Table of Contents

- Inspiration
- What it does?
- How we built it?
- Challenges we ran into?
- Installation
- Future Scopes
- Screenshots Time
- ML Model Statistics  
- Contributing
- License

## Inspiration
  
We were motivated by Yamaha Explore AI 2.0 to create a solution for the labour intensive job of counting industrial things like nuts, bolts and washers. Our app offers a interactive and simple to use UI and state of the art machine learning approach to object detection. 

## What it does?

This app uses your device camera and clicks pictures. We send these pictures to our server and return the output of the object detection/counting algorithm. We also have provided a feature of selecting a picture from your gallery instead of the camera.
  
## How we built it?

Initially, we developed a micromodel using the yolov5 framework to automate the annotation process for our dataset. Manual annotation of a large number of images proved to be a tedious task.

To enhance the model's ability to generalize and improve testing accuracy, we applied data augmentation techniques to our dataset.

Subsequently, we utilized the augmented dataset to train a customized model based on the ultralytics/Yolov8 model. This involved adjusting multiple parameters to achieve the desired output.

For handling requests in the backend, we established a flask server of small scale. To simplify maintenance and deployment, we containerized the entire backend using Docker.

The application for this project was initially designed using figma, followed by its implementation in the flutter framework.
  
## Challenges we ran into?

We had trouble efficiently training the ultralytics/Yolov8 model since the dataset that was made available for training it was so small. We used data augmentation techniques to fictitiously expand the dataset's size in order to solve this problem. In order to provide diversity and strengthen the model's generalisation abilities, several changes were applied to the images throughout the augmentation phase.

The absence of annotations in the supplied photographs was another issue we ran into. Since it was not possible to manually annotate the photographs within the allotted time, we created our own micromodel. This micromodel was created expressly to automatically annotate the photographs, lessening the workload associated with manual annotation.

Furthermore, during the training process of the custom model, we encountered challenges related to parameter tuning and optimization. Finding the optimal set of parameters required iterations and experimentation to achieve the desired output and performance.

Despite these challenges, we successfully overcame them by employing data augmentation techniques, developing a micromodel for automatic annotation, and refining the model's parameters to achieve the desired results.
  
## Accomplishments that we're proud of?

We are proud that this application is working and our AI model is integrated so well with Flutter😄.

Since, had to develop our own method for automatic annotation of images we're proud that it worked flawlessly.

Our final model had great generalization power and high testing accuracy and performed well in the live testing done by the judges.

This project overall was a big success for our team as we also won the 1st Prize in the hackathon.  

## Installation

  You can just install the apk of this application ang you're good to go.

## Future Scopes

Although this project is ready, there is always scope for more improvement

- We will try to implement a separate model for background separation to help with noisy backgrounds.

- We will try to improve efficiency of our model for faster runtime.

## 📸 Screenshots Time
<p align="middle">
<img src="https://github.com/The-Powerpuff-Rangers/nutcrackers/assets/74452705/76aecb64-1d10-482a-a575-7bb63a0be317" width="40%"/> 
<img src="https://github.com/The-Powerpuff-Rangers/nutcrackers/assets/74452705/6001c672-f5c2-4191-b9ca-33ad4169e69d" width="40%"/> 
<img src="https://github.com/The-Powerpuff-Rangers/nutcrackers/assets/74452705/e2bc5ad6-008d-4fc1-805e-b9e51f64fa4f" width="40%"/>
<img src="https://github.com/The-Powerpuff-Rangers/nutcrackers/assets/74452705/98d2b7dd-e221-431b-84c1-50be78cd9283" width="40%"/>
</p>

## ML Model Statistics
![image](https://github.com/The-Powerpuff-Rangers/nutcrackers/assets/74452705/8b28f1de-9a87-431e-bf21-319449e9dc12)
![image](https://github.com/The-Powerpuff-Rangers/nutcrackers/assets/74452705/1c8b8fc8-a4d2-40ec-acf9-dde06c6bf89b)
 
## Contributing

Since this project was built during Yamaha Explore AI 2.0, we would be seldomly improving this product. However we encourage you to contribute this repo and take it more as a tutorial of how this project was built. If you have any suggesstions or want to make some changes, feel free to create a PR or an issue.

## License

This project is GNU [Licensed](./LICENSE)


