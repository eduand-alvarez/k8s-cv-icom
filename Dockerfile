FROM bitnami/pytorch-intel:latest
ENV DEBIAN_FRONTEND=noninteractive

USER root

# update apt-get 
RUN apt-get update; apt-get autoremove

RUN apt-get install -y \
    cdo \
    nco \
    gdal-bin \
    libgdal-dev \
    libjemalloc-dev \
    awscli \
    cmake \
    apt-utils \
    python3-dev \
    libssl-dev \
    libffi-dev \
    libncurses-dev \
    libgl1 \
    ffmpeg \
    libsm6 \
    libxext6 \
    numactl

# adding docker root directory folder and content
ADD dockerRoot /

# setting working directory
WORKDIR /kubeflow

# install all python dependancies 
RUN pip3 install --user --no-cache-dir -r ../requirements.txt

# create env variables
ARG http_proxy
ARG https_proxy
ARG no_proxy

# assign variable value and run setup.sh
RUN export http_proxy=$http_proxy; export https_proxy=$https_proxy; export no_proxy=$no_proxy; /setup.sh; rm -f /setup.sh

# run startup script
CMD /startup.sh