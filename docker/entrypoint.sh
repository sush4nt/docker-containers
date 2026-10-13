#!/usr/bin/env bash
set -euo pipefail

# A fresh named volume can come up root-owned.
[[ -w /envs ]] || sudo chown "$(id -u):$(id -g)" /envs
mkdir -p /envs/.jupyter/kernels

jupyter lab --ip=0.0.0.0 --port=8888 --no-browser \
    --ServerApp.root_dir=/workspace \
    --IdentityProvider.token="${JUPYTER_TOKEN:-}" \
    > /tmp/jupyter.log 2>&1 &

# First start only: build the profile's default env (progress: docker compose logs -f <service>).
if [[ -n "${DEFAULT_ENV:-}" && ! -e "/envs/.jupyter/kernels/${DEFAULT_ENV}" ]]; then
    mkenv "$DEFAULT_ENV" "${DEFAULT_PYTHON:-3.12}" "/opt/profiles/${DEFAULT_ENV}/requirements.txt" \
        || echo "!! default env '${DEFAULT_ENV}' failed; fix and rerun mkenv inside the container"
fi

exec "$@"
