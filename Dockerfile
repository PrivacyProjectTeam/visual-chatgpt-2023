FROM python:3.8-slim-buster

ENV OPENAI_API_KEY=${OPENAI_API_KEY}
ENV PYTHONFAULTHANDLER=1 \
    PYTHONHASHSEED=random \
    PYTHONUNBUFFERED=1

RUN apt-get update -y && apt-get install -y git curl wget

RUN git clone https://github.com/microsoft/visual-chatgpt.git

WORKDIR /visual-chatgpt/

RUN pip install --upgrade pip && pip install opencv-python
RUN sed '/opencv/d' requirement.txt > temp.txt && mv temp.txt requirement.txt
RUN pip install -r requirement.txt
RUN bash ./download.sh

RUN mkdir /visual-chatgpt/image && chmod 777 /visual-chatgpt/image

CMD ["python", "visual_chatgpt.py"]
