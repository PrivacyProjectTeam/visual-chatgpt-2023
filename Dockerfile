# Start with a base image
FROM continuumio/miniconda3:4.9.2

# Set the working directory
WORKDIR /app

# Clone the repo
RUN apt-get update && apt-get -y install git && \
    git clone https://github.com/microsoft/visual-chatgpt.git

# Create a new environment
RUN conda create -n visgpt python=3.8 && \
    echo "conda activate visgpt" >> ~/.bashrc

# Activate the new environment
SHELL ["/bin/bash", "-c"]
RUN source ~/.bashrc

# Install the required packages
RUN conda install -n visgpt -c conda-forge --file visual-chatgpt/requirements.txt

# Download the models
RUN cd visual-chatgpt/scripts && \
    python download_models.py

# Set the default command to run when a container is launched
CMD ["python", "visual-chatgpt/app.py"]
