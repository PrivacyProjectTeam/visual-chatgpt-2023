FROM continuumio/miniconda3

RUN apt-get update && \
    apt-get install -y git

RUN git clone https://github.com/microsoft/visual-chatgpt.git

WORKDIR /visual-chatgpt

RUN conda create -n visgpt python=3.8 && \
    echo "conda activate visgpt" >> ~/.bashrc

SHELL ["conda", "run", "-n", "visgpt", "/bin/bash", "-c"]

RUN pip install -r requirements.txt

ENV OPENAI_API_KEY={Your_Private_Openai_Key}

CMD ["python", "visual_chatgpt.py", "--load", "ImageCaptioning_cpu,Text2Image_cpu"]
