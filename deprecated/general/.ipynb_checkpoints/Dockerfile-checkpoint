FROM python:3.8-slim-bullseye

RUN apt-get clean && \
    apt-get update --fix-missing

RUN apt-get update && apt-get install -y git
RUN apt-get update && apt-get install -y sudo

RUN apt-get update && apt-get install --no-install-recommends -y \
    # git=1:2.30.2-1 \
    vim=2:8.2.2434-3+deb11u1 \
    nano=5.4-2+deb11u2 \
    htop=3.0.5-7 \
    tmux=3.1c-1+deb11u1 \
    libgomp1=10.2.1-6 \
    cowsay=3.03+dfsg2-8 \
    awscli=1.19.1-1 \
    # sudo=1.9.5p2-3 \
    zip=3.0-12 \
    unzip=6.0-26+deb11u1 \
    openssh-client=1:8.4p1-5+deb11u1 \
    wget=1.21-1+deb11u1 \
    xclip=0.13-2 \
    tree=1.8.0-1+b1 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

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

# avoid sklearn deprecated error as some dependencies are yet to upgrade
ENV SKLEARN_ALLOW_DEPRECATED_SKLEARN_PACKAGE_INSTALL=True

## install some important tools and libraries
COPY requirements.txt /tmp
RUN pip install pip==23.0
RUN pip install -r /tmp/requirements.txt

# exposing the port and configuring plotly-dash
# ENV DASH_DEBUG_MODE False
# EXPOSE 8050
# CMD ["gunicorn", "-b", "0.0.0.0:8050", "--reload", "app:server"]

## jupyter notebook extensions setup
RUN pip install jupyter_contrib_nbextensions
RUN jupyter contrib nbextension install --user
RUN jupyter contrib nbextension install
RUN jupyter nbextension enable codefolding/main
RUN jupyter nbextension enable collapsible_headings/main
RUN jupyter nbextension enable execute_time/ExecuteTime
RUN jupyter nbextension enable livemdpreview/livemdpreview
RUN jupyter nbextension enable scratchpad/main

# clear matplotlib cache to avoid font not found warnings
RUN rm ~/.cache/matplotlib -fr

# install future_custom_functions framework
# COPY . /custom_functions
# WORKDIR /custom_functions
# RUN python setup.py install

USER devuser
WORKDIR /workspace/