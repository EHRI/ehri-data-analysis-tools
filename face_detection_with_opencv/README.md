## Using OpenCV for Face Detection

OpenCV is a very popular, free and open source software system used for a large variety of computer vision applications. This article is intended to help you get started in experimenting with OpenCV and as an interesting example the article discusses how to detect faces in images.

![alt_text](./out-2016.477.1_001_001_0010.jpg?raw=true "Example output file for 2016.477.1_001_001_0010.jpg")


Note that face detection is a much different, and much simpler task than facial recognition. Face detection uses a computer vision algorithm to detect the existence and location of face images within an image file. Facial recognition can be used to identify a person or match face images with each other. 

One could imagine a large collection of scanned archival images, some of which contain photographs of people, and an archival user would be interested in locating and viewing these photographs where they exist in the collection.

OpenCV is highly optimized for certain tasks, including face detection. There are many articles and tutorials on using OpenCV in a Python environment, so that is what we will discuss here.

This article assumes you have Linux installed and available to you and you can log in to the command line terminal. These examples were built with Ubuntu 18.04 (LTS), which uses the "apt" (Advanced Packaging Tool) system for installing software packages.

There are some paths in the article that assume you are running Ubuntu under Windows Subsystem for Linux (WSL), but most operations will be very similar if you are running Ubuntu in some other environment such as a Linux server or Linux desktop or VirtualBox environment.

Ensure you have python3 installed by entering "python3" in the command line (and press Enter). If you see something like this, you have Python 3 installed. The exact version of Python may not be critically important, but earlier or later versions may work somewhat differently. Ubuntu 18.04 comes with Python 3 already installed, invoked with "python3".

```
$python3
Python 3.6.5 (default, Apr  1 2018, 05:46:30)
[GCC 7.3.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>>
```
Please note that You may have to enter
```
quit()
```
in order to exit the Python environment. An alternative method to exit is pressing Ctl-D (Control-D).
You may be prompted to enter your Linux user's password.

Below are output files indicating that the system has identified faces in the images.

https://raw.githubusercontent.com/michaelrlevy/face_detection_with_opencv/master/1997.A.0245_001_001_0001.jpg


In order to use very recent versions of OpenCV, you will need to download and compile the program "from source," and there are many resources available to help you do that. However, the purpose of this article is to help get started with OpenCV, and it is now rather easy to install with precompiled packages, which makes the installation task much easier and less error-prone.

"sudo" is a Linux command that gives your Linux user a higher level of privileges. Some commands below begin with "sudo"; the system may will prompt you for your user's password before proceeding. With many of the "apt" install scripts you will need to respond "Y" when prompted "Do you want to continue? [Y]

If you have a newly installed Ubuntu system, you should update packages by running:

```
sudo apt update
```

followed by

```
sudo apt-get upgrade
```

This may take some time and may also require you to enter "Y" to allow the update package to proceed, and you may at different times be prompted to allow the update to restart Ubuntu Linux. If you are using this in WSL, this will just restart Linux, without restarting your Windows computer.

It is possible to install OpenCV with the "apt" system. However "apt" may have a rather old version of OpenCV. A much newer version of OpenCV may be installed through using the "pip" system, which is a recommended tool for installing many Python packagers. Luckly, the OpenCV version available through "pip" is much newer. Since we wish to use Python3, we will install a version of "pip" that is involved through "pip3" as in the examples below. Here is how to install "pip3":

```
sudo apt install python3-pip
```

This also may take some time and you may have to enter "Y" to allow the update to proceed.

Enter
```
sudo pip3 install opencv-python
```

At this point you should be able to enter a Python environment by entering
```
python3
```
..and then enter these two lines:

```
import cv2 as cv
print(cv.__version__)
..and you should see something like this:
```
```
$ python3
Python 3.6.8 (default, Jan 14 2019, 11:02:34)
[GCC 8.0.1 20180414 (experimental) [trunk revision 259383]] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import cv2 as cv
>>> print(cv.__version__)
4.1.0
>>>
```
This indicates that you can access OpenCV version 4.1.0, which is a relatively new version of OpenCV.

Now install these two packages:
```
sudo apt-get install python-numpy
sudo apt-get install python3-matplotlib
```

Create a directory and change the working directory to work there:
```Bash
mkdir face_detection
cd face_detection
```

There are two face detection algorithms that have been implemented in OpenCV for some time, the Local Binary Pattern(LBP) classifier. and the Haar Classifier. In this article we will use the Haar Classifier. There are also newer face classifiers that are included in newer versions of OpenCV and other methods that can be added if desired, but the Haar produces good results and is easy to implement.

For the next step you will need to be able to edit a text file. Unfortunately, there are strong warnings in the current WSL system against using a Windows tool to edit files in the WSL environment. It is not terribly difficult to locate the files, but you should not edit them, currently, except through Linux tools. Many experienced Linux users use a tool call "vi" or "vim". An easy too to learn is "nano" which can be invoked simply with
```
nano
```
or else with a file name. Please enter
```
nano face-detect.py 
```
Nano does take some learning. You will find hints and prompts at the bottom of the nano screen. The carat character ^ indicates the Control key, so for example the hint for "Write Out" is "^D" which indicdates Control-d. Exiting through ^X (Control-X) will prompt you to save the file.

Go to your Windows computer to the C: drive and create these directories:
```
C:\face-detect\
C:\face-detect\inputfiles\
C:\face-detect\outputfiles
```
and copy some image files into those directories. You may use the example files in this project--the ones that do not begin with "out-"--as examples, and download them to C:\face-detect\inputfiles\

You should be able to enter the code below into your editor, save the code, and run it through entering

```
python3 face-detect.py
```

If run successfully, the output files will be written with the same file name as the input file but prepended with "out-", and will be placed in the C:\face-detect\outputfiles\ directory you created.

Note that in WSL Linux, the C: drive is represented as /mnt/c/ and each directory from there should be similar to Windows (although space characters must be handled specially), using slash characters instead of backslash characters. So where you see in the code 

```Python
source_filepattern = '/mnt/c/face-detect/inputfiles/*jpg'
```
it is indicating to the system the Windows location "C:\face-detect\inputfiles\" and the "*jpg" will cause the program to gather all of the files ending in "jpg" and send each file to be processed.

In the code example below, note a file path to files named haarcascade_frontalface_default.xml and haarcascade_eye.xml

As you can see the full path to those files is rather long and complex, and it may not be clear to you where the OpenCV package has placed these files. Here is a technique that may help you to locate those files. Linux provides a convenient method to search files in your Linux filesystem. First you may need to update the location database by running 'updatedb'. This may time some time to run, especially the first time. Then you can use the 'locate' command to look for filenames or search for partial filenames.
```
sudo updatedb
```
After this has run, you may enter
```
locate haarcascade
```
or
```
locate haarcascade_frontalface_default
```
On the system as tested the result is
/usr/local/lib/python3.6/dist-packages/cv2/data/haarcascade_frontalface_default.xml
and we use that path in cv.CascadeClassifier()

Here is the code. Note that it can also provide eye detection, but I have commented this out for this example.

```Python
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
```

In the project you will find a set of input images that you can copy into the input directory and a set of images that are output by the program. Note that for convenient display in this paper, the output images have been resized by 50% in width and height.

Displayed below are some example files indicating that OpenCV has detected faces in these images. Faces are indicated with red rectangles. The use case as described above has only to do with selecting images that have faces within a large set of images where only some have faces. To perform that task one would need only the images where any face is detected. However, it is interesting to have a visual indication of which parts of a small typical image set is recognized as being a face. In some examples, we can see faces that are not recognized by this method, and in the third image we can see that this method recognizes a face where there is none.

Note that some research indicate that another method Multi-task Cascaded Convolutional Networks (MTCNN) may do a better job of face detection than Haar while maintaining good speed of execution. For those considering a project using face detection, investigating MTCNN may be worthwhile.

![alt_text](out-1997.A.0245_001_001_0001.jpg?raw=true "Example output file from 1997.A.0245_001_001_0001")

![alt_text](out-1997.A.0245_001_001_0003.jpg?raw=true "Example output file from 1997.A.0245_001_001_0003")

![alt_text](out-2016.477.1_001_001_0005.jpg?raw=true "Example output file from 2016.477.1_001_001_0005")

![alt_text](out-2016.477.1_001_001_0010.jpg?raw=true "Example output file from 2016.477.1_001_001_0010")







