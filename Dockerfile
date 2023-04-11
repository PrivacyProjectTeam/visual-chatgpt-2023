FROM python:3.8-slim-buster

# Install mesa packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libgl1-mesa-glx \
    && rm -rf /var/lib/apt/lists/*

# Clone the repo
RUN git clone https://github.com/microsoft/visual-chatgpt.git

# Go to directory
WORKDIR visual-chatgpt

# Create a new environment
RUN conda create -n visgpt python=3.8

# Activate the new environment
SHELL ["conda", "run", "-n", "visgpt", "/bin/bash", "-c"]

# Prepare the basic environments
RUN pip install -r requirements.txt

# Prepare your private OpenAI key
ENV OPENAI_API_KEY={Your_Private_Openai_Key}

# Start Visual ChatGPT
CMD ["python", "visual_chatgpt.py", "--load", "ImageCaptioning_cpu,Text2Image_cpu"]
