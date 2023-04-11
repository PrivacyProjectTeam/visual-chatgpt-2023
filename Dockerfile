FROM nvidia/cuda:11.4.0-cudnn8-runtime-ubuntu20.04

# Update the Ubuntu package list
RUN apt-get update

# Install some common utilities
RUN apt-get install -y wget git

# Install Miniconda
RUN wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh \
  && sh ~/miniconda.sh -b -p /opt/conda \
  && rm ~/miniconda.sh \
  && /opt/conda/bin/conda clean -ya

# Set the PATH environment variable
ENV PATH /opt/conda/bin:$PATH

# Clone the repo
RUN git clone https://github.com/microsoft/visual-chatgpt.git

# Create a new environment
RUN conda create -n visgpt python=3.8

# Activate the new environment
SHELL ["conda", "run", "-n", "visgpt", "/bin/bash", "-c"]

# Install the required packages
RUN pip install -r visual-chatgpt/requirements.txt

# Download the models
RUN python visual-chatgpt/scripts/download_models.py

# Set the default command to run when a container is launched
CMD ["python", "visual-chatgpt/visual_chatgpt.py"]
