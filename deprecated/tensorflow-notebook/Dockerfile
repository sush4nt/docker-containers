# Using the Jupyter TensorFlow notebook as the base image
# FROM jupyter/tensorflow-notebook
FROM tensorflow/tensorflow:latest-gpu

USER root

# Cleaning up APT and installing some packages
RUN apt-get clean && \
    apt-get update --fix-missing && \
    apt-get install -y git sudo vim nano htop tmux libgomp1 cowsay awscli zip unzip openssh-client wget xclip tree && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Setting the working directory
WORKDIR /workspace/

# Create a user and map it with system host to avoid permission issues
RUN id jovyan &>/dev/null || (addgroup --gid 1000 jovyan && \
    adduser --disabled-password --gecos "" --uid 1000 --gid 1000 jovyan && \
    adduser jovyan sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers)
ENV HOME /home/jovyan

# Optional: switch to user 'jovyan' if required for better security practices
# USER jovyan

# tmux based workspace setup
COPY ./scripts/. /home/jovyan/
RUN echo 'alias work="bash /home/jovyan/.workspace_setup.sh"' >> /home/jovyan/.bashrc
RUN echo 'PATH="/home/jovyan/.local/bin:$PATH"' >> /home/jovyan/.bashrc
ENV PATH="/home/jovyan/.local/bin:$PATH"
ENV PIP_NO_CACHE_DIR=1

# Avoid sklearn deprecated error as some dependencies are yet to upgrade
ENV SKLEARN_ALLOW_DEPRECATED_SKLEARN_PACKAGE_INSTALL=True

# Install some important tools and libraries
COPY requirements.txt /tmp/
RUN pip install --upgrade pip && \
    pip install -r /tmp/requirements.txt

# Clear matplotlib cache to avoid font not found warnings
RUN rm -fr /home/jovyan/.cache/matplotlib

# Final setting up of user and workspace
USER jovyan
WORKDIR /workspace/
