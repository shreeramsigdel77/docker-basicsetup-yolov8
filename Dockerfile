# Based NGC pytorch 21.10
FROM nvcr.io/nvidia/pytorch:21.10-py3

# Configuring tzdata for docker freeze
ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Prepare install
RUN apt-get -y update && apt-get -y upgrade

# Add the following line to get native library of OpenCV.
# RUN apt-get install -y libopencv-dev
# 必要なシステムパッケージをインストール
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    libopencv-dev nano sudo && \
    rm -rf /var/lib/apt/lists/*



# Install yolov8
RUN pip install ultralytics==8.0.81

# Install OpenCV (c++)
# Configure Version (yolov8 need cv < 4.3)
RUN pip install "opencv-python-headless<4.3"

# Update pytorch for cuda=11.4 (https://github.com/pytorch/pytorch/issues/75992#issuecomment-1102959704)
# yolov8 need torch > 10.1
RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu113

ENV PYTHONIOENCODING=utf8

# Expose port for Jupyter Notebook
EXPOSE 8877   #makesure the port is available


# 新規ユーザを作成して sudo 権限を付与
RUN groupadd --gid 1000 user && \
    useradd --uid 1000 --gid 1000 -m user && \
    usermod -aG sudo user && \
    echo "user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/user && \
    chmod 0440 /etc/sudoers.d/user


# Set the working directory
WORKDIR /workspace
RUN chown -R 1000:1000 /workspace

# ユーザを切り替え
USER user


# Command to start Jupyter Notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8877", "--no-browser", "--allow-root", "--NotebookApp.token=''"]
