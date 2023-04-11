FROM python:3.8-slim-buster

# Install Git
RUN apt-get update && apt-get install -y git

# Clone the repo
RUN git clone https://github.com/microsoft/visual-chatgpt.git

# Go to directory
WORKDIR /visual-chatgpt

# create a new environment
RUN conda create -n visgpt python=3.8

# activate the new environment
SHELL ["conda", "run", "-n", "visgpt", "/bin/bash", "-c"]

# prepare the basic environments
RUN pip install -r requirements.txt

# prepare your private OpenAI key (for Linux)
ENV OPENAI_API_KEY=$OPENAI_API_KEY

# Start Visual ChatGPT
CMD ["python", "visual_chatgpt.py", "--load", "ImageCaptioning_cpu,Text2Image_cpu"]
