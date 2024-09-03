# Based NGC pytorch 21.10
FROM nvcr.io/nvidia/pytorch:21.10-py3

# Configuring tzdata for docker freeze
ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Prepare install
RUN apt-get -y update && apt-get -y upgrade

# Add the following line to get native library of OpenCV.
RUN apt-get install -y libopencv-dev

# Install yolov8
RUN pip install ultralytics

# Install OpenCV (c++)
# Configure Version (yolov8 need cv < 4.3)
RUN pip install "opencv-python-headless<4.3"

# Update pytorch for cuda=11.4 (https://github.com/pytorch/pytorch/issues/75992#issuecomment-1102959704)
# yolov8 need torch > 10.1
RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu113

USER root
ENV PYTHONIOENCODING=utf8

# Expose port for Jupyter Notebook
EXPOSE 5000

# Set the working directory
WORKDIR /workspace

# Command to start Jupyter Notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=5000", "--no-browser", "--allow-root", "--NotebookApp.token=''"]

