# optical-character-recognition
A MATLAB application for automatic vehicle license plate recognition using image processing techniques and Optical Character Recognition (OCR).

## Overview

This project implements a MATLAB-based graphical user interface (GUI) for automatic license plate recognition.

Users can upload an image of a license plate, apply several image preprocessing techniques, and extract the license plate characters using MATLAB's built-in OCR engine.

The main objective of the project was to investigate how different image enhancement and segmentation techniques improve OCR performance and recognition accuracy.

## Features

- Interactive MATLAB GUI
- License plate image upload
- Image sharpening
- Grayscale conversion
- Automatic threshold selection (Otsu algorithm)
- Image binarization
- Region of Interest (ROI) extraction
- Character region detection
- Optical Character Recognition (OCR)
- Display of recognized license plate text

## Processing Pipeline

The recognition process consists of the following steps:

1. Upload a license plate image.
2. Sharpen the image to improve edge visibility.
3. Convert the image to grayscale.
4. Compute the optimal threshold using the Otsu algorithm.
5. Binarize the image.
6. Detect the license plate region.
7. Identify character regions using connected component analysis (`regionprops`).
8. Apply MATLAB's built-in OCR function to recognize the detected characters.
9. Display the recognized license plate text in the GUI.

## Technologies

- MATLAB
- GUIDE (MATLAB GUI)
- Image Processing Toolbox
- Computer Vision Toolbox

## Example

![Application GUI](images/gui-example.png)

## Future Improvements

- Automatic license plate localization from full vehicle images
- Deep learning-based OCR models
- Support for multiple license plate formats
- Higher robustness under varying lighting conditions
