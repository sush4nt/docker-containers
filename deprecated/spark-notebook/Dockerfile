FROM jupyter/pyspark-notebook

USER root

RUN apt-get clean && \
    apt-get update --fix-missing

WORKDIR /workspace/

# create a user and map it with system host, to avoid permission issues
# RUN addgroup --gid 1000 jovyan
# RUN adduser --disabled-password --gecos "" --uid 1000 --gid 1000 jovyan
# RUN adduser jovyan sudo
# RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
# ENV HOME /home/jovyan

RUN id jovyan &>/dev/null || (addgroup --gid 1000 jovyan && \
    adduser --disabled-password --gecos "" --uid 1000 --gid 1000 jovyan && \
    adduser jovyan sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers)

# USER jovyan

RUN apt-get update && apt-get install -y git
RUN apt-get update && apt-get install -y sudo

RUN sudo apt-get update && sudo apt-get install --no-install-recommends -y \
    # git=1:2.30.2-1 \
    vim \
    nano \
    htop \
    tmux \
    libgomp1 \
    cowsay \
    awscli \
    # sudo=1.9.5p2-3 \
    zip\
    unzip \
    openssh-client \
    wget \
    xclip\
    tree \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# # create a user and map it with system host, to avoid permission issues
# RUN addgroup --gid 1000 jovyan
# RUN adduser --disabled-password --gecos "" --uid 1000 --gid 1000 jovyan
# RUN adduser jovyan sudo
# RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
# ENV HOME /home/jovyan

# tmux based workspace setup
COPY ./scripts/. /home/jovyan/
RUN echo 'alias work="bash /home/jovyan/.workspace_setup.sh"' >> ~/.bashrc
RUN echo 'PATH="/home/jovyan/.local/bin:$PATH"' >> ~/.bashrc
ENV PATH="/home/jovyan/.local/bin:$PATH"
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

# ## jupyter notebook extensions setup
# RUN pip install jupyter_contrib_nbextensions
# RUN jupyter contrib nbextension install --user
# RUN jupyter contrib nbextension install
# RUN jupyter nbextension enable codefolding/main
# RUN jupyter nbextension enable collapsible_headings/main
# RUN jupyter nbextension enable execute_time/ExecuteTime
# RUN jupyter nbextension enable livemdpreview/livemdpreview
# RUN jupyter nbextension enable scratchpad/main

# clear matplotlib cache to avoid font not found warnings
RUN rm ~/.cache/matplotlib -fr

# install future_custom_functions framework
# COPY . /custom_functions
# WORKDIR /custom_functions
# RUN python setup.py install

# USER jovyan
# WORKDIR /workspace/