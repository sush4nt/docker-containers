FROM python:3.12.7-slim-bullseye

RUN apt-get clean && \
    apt-get update --fix-missing

RUN apt-get update && apt-get install -y git
RUN apt-get update && apt-get install -y sudo

RUN apt-get update && apt-get install --no-install-recommends -y \
    vim \
    nano \
    htop \
    tmux \
    libgomp1 \
    cowsay \
    awscli \
    zip \
    unzip \
    openssh-client \
    wget \
    xclip \
    tree \
    dos2unix \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# create a user and map it with system host, to avoid permission issues
RUN addgroup --gid 1000 devuser
RUN adduser --disabled-password --gecos "" --uid 1000 --gid 1000 devuser
RUN adduser devuser sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
ENV HOME /home/devuser

# tmux based workspace setup
COPY ./scripts/. /home/devuser/
RUN dos2unix /home/devuser/.tmux.conf /home/devuser/.workspace_setup.sh
RUN echo 'alias work="bash /home/devuser/.workspace_setup.sh"' >> ~/.bashrc
RUN echo 'PATH="/home/devuser/.local/bin:$PATH"' >> ~/.bashrc
ENV PATH="/home/devuser/.local/bin:$PATH"
ENV PIP_NO_CACHE_DIR=1

# avoid sklearn deprecated error as some dependencies are yet to upgrade
ENV SKLEARN_ALLOW_DEPRECATED_SKLEARN_PACKAGE_INSTALL=True

## install some important tools and libraries
COPY requirements.txt /tmp
RUN pip install pip
RUN pip install -r /tmp/requirements.txt

USER devuser
WORKDIR /workspace/