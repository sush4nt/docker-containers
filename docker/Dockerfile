# One skeleton for every workbench. Profiles differ only by build args (system
# packages) and runtime config in compose.yaml. Python packages live in /envs.
ARG PYTHON_VERSION=3.12
ARG UV_VERSION=latest
FROM ghcr.io/astral-sh/uv:${UV_VERSION} AS uv

FROM python:${PYTHON_VERSION}-slim-bookworm

ARG EXTRA_APT=""
ARG USER_UID=1000
ARG USER_GID=1000

# man1 dir is missing in slim images and breaks the OpenJDK postinst.
RUN mkdir -p /usr/share/man/man1 \
 && apt-get update && apt-get install -y --no-install-recommends \
        sudo git curl ca-certificates openssh-client procps \
        htop tmux vim nano tree zip unzip libgomp1 \
        ${EXTRA_APT} \
 && rm -rf /var/lib/apt/lists/*

RUN groupadd -o --gid ${USER_GID} devuser \
 && useradd -o --uid ${USER_UID} --gid ${USER_GID} -m -s /bin/bash devuser \
 && echo 'devuser ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/devuser \
 && mkdir -p /envs /workspace && chown devuser:devuser /envs /workspace

COPY --from=uv /uv /uvx /usr/local/bin/

# Jupyter server gets its own env so project envs never break it.
RUN uv venv /opt/jupyter --python /usr/local/bin/python3 \
 && uv pip install --no-cache --python /opt/jupyter jupyterlab ipywidgets

COPY docker/bin/ /opt/dsw/bin/
COPY docker/entrypoint.sh docker/bashrc.sh /opt/dsw/
COPY --chown=devuser:devuser docker/tmux.conf /home/devuser/.tmux.conf
# Strip CRLF in case the repo was checked out on Windows without .gitattributes.
RUN sed -i 's/\r$//' /opt/dsw/bin/* /opt/dsw/*.sh /home/devuser/.tmux.conf \
 && chmod +x /opt/dsw/bin/* /opt/dsw/entrypoint.sh \
 && echo '. /opt/dsw/bashrc.sh' >> /home/devuser/.bashrc

# Cache, managed Pythons and envs share one volume: survives rebuilds and lets uv hardlink.
ENV PATH="/opt/dsw/bin:/home/devuser/.local/bin:${PATH}:/opt/jupyter/bin" \
    UV_CACHE_DIR=/envs/.cache \
    UV_PYTHON_INSTALL_DIR=/envs/.python \
    UV_PYTHON_PREFERENCE=only-managed

USER devuser
RUN mkdir -p /home/devuser/.local/share/jupyter \
 && ln -s /envs/.jupyter/kernels /home/devuser/.local/share/jupyter/kernels

# Picked up by VS Code / Cursor Dev Containers on attach and reopen.
LABEL devcontainer.metadata='[{"remoteUser":"devuser","customizations":{"vscode":{"extensions":["ms-python.python","ms-toolsai.jupyter"],"settings":{"python.venvPath":"/envs"}}}}]'

WORKDIR /workspace
ENTRYPOINT ["/opt/dsw/entrypoint.sh"]
CMD ["sleep", "infinity"]
