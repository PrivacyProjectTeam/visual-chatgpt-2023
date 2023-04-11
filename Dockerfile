FROM python:3.8-slim-buster

# Set environment variables
ENV OPENAI_API_KEY=${OPENAI_API_KEY}
ENV PYTHONFAULTHANDLER=1 \
    PYTHONHASHSEED=random \
    PYTHONUNBUFFERED=1

# Install dependencies
RUN apt-get update -y && apt-get install -y git curl wget

# Clone repository
RUN git clone https://github.com/microsoft/visual-chatgpt.git

# Move to repository directory
WORKDIR /visual-chatgpt/

# Upgrade pip and install opencv-python
RUN pip install --upgrade pip && pip install opencv-python

# Remove opencv from requirements and install remaining requirements
RUN sed '/opencv/d' requirements.txt > temp.txt && mv temp.txt requirements.txt
RUN pip install -r requirements.txt

# Download files
RUN bash ./download.sh

# Create directory for images
RUN mkdir /visual-chatgpt/image && chmod 777 /visual-chatgpt/image

# Set command to run the application
CMD ["python", "visual_chatgpt.py"]
