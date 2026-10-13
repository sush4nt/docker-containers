# Sourced from ~/.bashrc inside every workbench container.

# Activate an env; also points `uv add/sync/run` at it instead of a slow ./.venv on the bind mount.
actenv() {
    source "/envs/${1:?usage: actenv <env>}/bin/activate" && export UV_PROJECT_ENVIRONMENT="/envs/$1"
}

# tmux layout: shell | htop / jupyter log. Re-running reattaches.
work() {
    if ! tmux has-session -t work 2>/dev/null; then
        tmux new-session -d -s work -c /workspace
        tmux split-window -h -t work
        tmux send-keys -t work 'htop' C-m
        tmux split-window -v -t work
        tmux send-keys -t work 'tail -f /tmp/jupyter.log' C-m
        tmux select-pane -t work -L
    fi
    tmux attach -t work
}

_dsw_envs() {
    [[ $COMP_CWORD -eq 1 ]] && mapfile -t COMPREPLY < <(compgen -W "$(ls /envs 2>/dev/null)" -- "${COMP_WORDS[1]}")
}
complete -F _dsw_envs actenv rmenv addpkg
