# mostly from:
#https://docs.opencv.org/3.4.1/d7/d8b/tutorial_py_face_detection.html

import os
import glob
import numpy as np
import cv2 as cv
face_cascade = cv.CascadeClassifier('/usr/local/lib/python3.6/dist-packages/cv2/data/haarcascade_frontalface_default.xml')
# uncomment the next line if you wish to locate eyes
#eye_cascade = cv.CascadeClassifier('/usr/local/lib/python3.6/dist-packages/cv2/data/haarcascade_eye.xml')

source_filepattern = '/mnt/c/face-detect/inputfiles/*jpg'
dest_dir = "/mnt/c/face-detect/outputfiles/out-"

def do_each_file( source_filepattern ):
    for imagefile in glob.glob(source_filepattern):
        filename = os.path.basename( imagefile )
        print(filename)
        outputfile = dest_dir + filename
        detect_face(imagefile, outputfile)
    return;

def detect_face( imgpath, outputfile ):
    img = cv.imread(imgpath)
    #print (img)
    gray = cv.cvtColor(img, cv.COLOR_BGR2GRAY)
    faces = face_cascade.detectMultiScale(gray, 1.3, 5)
    for (x,y,w,h) in faces:
        cv.rectangle(img,(x,y),(x+w,y+h),(0,0,255),4)
        roi_gray = gray[y:y+h, x:x+w]
        roi_color = img[y:y+h, x:x+w]
        # uncomment the next 3 lines to also add Haar eye detection
        #eyes = eye_cascade.detectMultiScale(roi_gray)
        #for (ex,ey,ew,eh) in eyes:
        #cv.rectangle(roi_color,(ex,ey),(ex+ew,ey+eh),(0,255,0),2)
    cv.imwrite( outputfile, img );
    return;

do_each_file( source_filepattern )
