FROM python:3.8-slim-bullseye

# install some dependencies
RUN apt-get update && apt-get install --no-install-recommends -y \
    git=1:2.30.2-1 \
    vim=2:8.2.2434-3+deb11u1 \
    # nano=4.8-1ubuntu1 \
    htop=3.0.5-7 \
    tmux=3.1c-1+deb11u1 \
    libgomp1=10.2.1-6 \
    cowsay=3.03+dfsg2-8 \
    awscli=1.19.1-1 \
    sudo=1.9.5p2-3 \
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

# install some important tools and libraries
COPY requirements.txt /tmp
RUN pip install pip==22.3.1
RUN pip install --no-cache-dir -r /tmp/requirements.txt

CMD gunicorn -b 0.0.0.0:8050 app.app:server
# install future_custom_functions framework
# COPY . /custom_functions
# WORKDIR /custom_functions
# RUN python setup.py install

USER devuser
WORKDIR /workspace/