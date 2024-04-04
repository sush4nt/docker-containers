FROM nvidia/cuda:11.7.1-base-ubuntu22.04

RUN apt-get clean && \
    apt-get update --fix-missing

RUN apt-get update && apt-get install -y git
RUN apt-get update && apt-get install -y sudo

# Build with some basic utilities
RUN apt-get update && apt-get install -y \
    python3-pip \
    apt-utils \
    vim \
    git \
    htop \
    tmux

# create a user and map it with system host, to avoid permission issues
RUN addgroup --gid 1000 devuser
RUN adduser --disabled-password --gecos "" --uid 1000 --gid 1000 devuser
RUN adduser devuser sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
ENV HOME /home/devuser

# tmux based workspace setup
COPY ./scripts/. /home/devuser/
RUN echo 'alias work="bash /home/devuser/.workspace_setup.sh"' >> ~/.bashrc
RUN echo 'PATH="/home/devuser/.local/bin:$PATH"' >> ~/.bashrc
ENV PATH="/home/devuser/.local/bin:$PATH"
ENV PIP_NO_CACHE_DIR=1

# Set bash as the default shell
ENV SHELL=/bin/bash

# # Create a working directory
# WORKDIR /app/

# alias python='python3'
RUN ln -s /usr/bin/python3 /usr/bin/python

# build with some basic python packages
RUN pip install \
    numpy \
    torch \
    notebook \ 
    jupyterlab

# # start jupyter lab
# CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--allow-root", "--no-browser"]
# EXPOSE 8888

USER devuser
WORKDIR /workspace/
