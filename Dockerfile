FROM continuumio/miniconda3:latest

# Clone the repo
RUN git clone https://github.com/microsoft/visual-chatgpt.git

# Set working directory
WORKDIR /visual-chatgpt

# Create a new environment
RUN conda create -n visgpt python=3.8

# Activate the new environment
SHELL ["conda", "run", "-n", "visgpt", "/bin/bash", "-c"]
RUN echo "conda activate visgpt" >> ~/.bashrc
ENV PATH /opt/conda/envs/visgpt/bin:$PATH

# Prepare the basic environments
RUN pip install -r requirements.txt

# Set OpenAI API key environment variable
ARG OPENAI_API_KEY
ENV OPENAI_API_KEY=$OPENAI_API_KEY

# Start Visual ChatGPT!
# You can specify the GPU/CPU assignment by "--load", the parameter indicates which 
# Visual Foundation Model to use and where it will be loaded to
# The model and device are separated by underline '_', the different models are separated by comma ','
# The available Visual Foundation Models can be found in the following table
# For example, if you want to load ImageCaptioning to cpu and Text2Image to cuda:0
# You can use: "ImageCaptioning_cpu,Text2Image_cuda:0"

# Advice for CPU Users
CMD ["python", "visual_chatgpt.py", "--load", "ImageCaptioning_cpu,Text2Image_cpu"]

# Advice for 1 Tesla T4 15GB  (Google Colab)                       
# CMD ["python", "visual_chatgpt.py", "--load", "ImageCaptioning_cuda:0,Text2Image_cuda:0"]
                                
# Advice for 4 Tesla V100 32GB                            
# CMD ["python", "visual_chatgpt.py", "--load", "ImageCaptioning_cuda:0,ImageEditing_cuda:0,
#     Text2Image_cuda:1,Image2Canny_cpu,CannyText2Image_cuda:1,
#     Image2Depth_cpu,DepthText2Image_cuda:1,VisualQuestionAnswering_cuda:2,
#     InstructPix2Pix_cuda:2,Image2Scribble_cpu,ScribbleText2Image_cuda:2,
#     Image2Seg_cpu,SegText2Image_cuda:2,Image2Pose_cpu,PoseText2Image_cuda:2,
#     Image2Hed_cpu,HedText2Image_cuda:3,Image2Normal_cpu,
#     NormalText2Image_cuda:3,Image2Line_cpu,LineText2Image_cuda:3"]
