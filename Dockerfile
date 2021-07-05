FROM tensorflow/tensorflow:latest-gpu-jupyter
WORKDIR /root

EXPOSE 80
#JUPYTER
EXPOSE 8888
#TENSORBOARD 
EXPOSE 6006
#Flask/GUnicorn
EXPOSE 5000

ENV SHELL /bin/bash
ENV PATH="/root/.local/bin:${PATH}"

#If recompile of some CUDA parts is necessary, also share between sessions
ENV CUDA_CACHE_PATH="/root/cache/cuda"
#Sometimes (with older NVIDIA cards) you need to specify a bigger size for the
#JIT compiler cache to avoid long recompiles between sessions
#Se necesitaba en tarjetas viejas
ENV CUDA_CACHE_MAXSIZE="4294967296"

#Download tensorflow and huggingface models here to share between sessions
ENV TFHUB_CACHE_DIR="/root/cache/tfhub"
#Check if you need to add other caches
ENV PYTORCH_PRETRAINED_BERT_CACHE="/root/cache/hug"
ENV TRANSFORMERS_CACHE="/root/cache/hug"

ENV NLTK_DATA=/root/cache/nltk/

#ENV TZ=America/Mexico_City
#RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN ln -sf /usr/share/zoneinfo/America/Mexico_City /etc/localtime

RUN pip install --upgrade pip

RUN apt update -y && apt upgrade -y
RUN apt install -y zip
RUN apt install -y git git-lfs
RUN apt install -y vim 

#R
#RUN apt install -y r-base
#RUN Rscript -e 'install.packages("optparse",repo="http://cran.rstudio.com/",dependencies=TRUE)'
#RUN Rscript -e 'install.packages("wordcloud",repo="http://cran.rstudio.com/",dependencies=TRUE)'
#
#RUN apt install -y libzmq3-dev libcurl4-openssl-dev libssl-dev
#RUN apt install -y libcairo2-dev
#RUN apt install -y xml2 libxml2-dev 
##Ultimo status, parece que falta shiny
##RUN Rscript -e "install.packages(c('repr', 'IRdisplay', 'IRkernel'),type='source',repo=c('http://cran.r-project.org/'),dependencies=TRUE)"
##RUN Rscript -e 'IRkernel::installspec()'

#python
RUN pip install pytest
RUN pip install pylint
RUN pip install tqdm

RUN pip install pandas
RUN pip install tables
RUN pip install sklearn
RUN pip install matplotlib
RUN pip install seaborn
RUN pip install colorcet

RUN pip install boto3
RUN pip install faiss-cpu
RUN pip install html2text
RUN pip install protobuf
RUN pip install flask flask-cors

RUN pip install tensorflow-hub
RUN pip install tensorflow-text
#RUN pip install keras

RUN pip install torch torchvision
#RUN pip install sentencepiece
RUN pip install transformers
RUN pip install sentence_transformers
#Reported https://github.com/huggingface/datasets/issues/1581
#Throws a Permission error to /.cache. 
#Either do not import datasets or create the dir and give permissions
RUN pip install datasets
RUN mkdir /.cache
RUN chmod 777 /.cache

#Versiones de CUDA que se necesitan para las versiones especificas de TF
#https://github.com/tensorflow/hub/issues/485
#RUN apt-get remove libcublas10 -y
#RUN apt-get update && apt-get install -y --no-install-recommends libcublas10=10.2.1.243-1

#RUN pip3 install jupyter-tabnine
#RUN jupyter nbextension install --py jupyter_tabnine
#RUN jupyter nbextension enable --py jupyter_tabnine
#RUN jupyter serverextension enable --py jupyter_tabnine
