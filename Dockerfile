FROM laineil/jupyter-base-notebook:python-3.10-cuda-12.1-base-rocky8

# Ensure commands run as root
USER root

# Configuring tzdata for docker freeze
ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Update package list and install dependencies using dnf
RUN dnf update -y && dnf install -y \
    wget \
    python3-pip \
    nano \
    sudo && \
    dnf clean all && rm -rf /var/cache/dnf

# Install pytorch with CUDA support
RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

ENV PYTHONIOENCODING=utf8

# Expose port for Jupyter Notebook
EXPOSE 5055

# Create sudo group and a new user with sudo permissions
RUN groupadd --gid 2000 sudo && \
     groupadd --gid 2001 user && \
     useradd --uid 2000 --gid 2001 -m user && \
     usermod -aG sudo user && \
     echo "user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/user && chmod 0440 /etc/sudoers.d/user


# Ensure user has proper ownership and global permissions for home and workspace directories
RUN mkdir -p /workspace && \
     chown -R user:user /workspace && \
     chmod -R 777 /workspace && \
     chown -R user:user /home/user /home/jovyan && \
     chmod -R 777 /home/user /home/jovyan

# Set the working directory
WORKDIR /workspace

# Copy to install packages
COPY . /workspace

# Switch to user
USER user

# Command to start Jupyter Notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=5055", "--no-browser", "--allow-root", "--NotebookApp.token=''"]
