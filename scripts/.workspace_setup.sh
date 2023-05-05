session="work"
tmux start-server
tmux new-session -d -s $session

# select pane 1 and switch back to pane 0
tmux split-window -h
tmux selectp -t 0

# select pane 2 and switch back to pane 0
tmux split-window -vf
tmux selectp -t 0

# select pane 2 and open htop in it
tmux selectp -t 2
tmux send-keys "htop" C-m

# select pane 1 and open jupyter-notebook in it
tmux selectp -t 1
tmux send-keys "sudo jupyter notebook --ip 0.0.0.0 --no-browser --allow-root --NotebookApp.token='' --NotebookApp.password=''" C-m

# return to pane 0 and attach session
tmux selectp -t 0
tmux send-keys '/usr/games/cowsay -f milk Hello! Welcome to DSML Docker Container!' C-m
tmux attach-session -t $session
