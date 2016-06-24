#!/bin/bash

if tmux has-session -t $1
then
    echo "lol"
    tmux attach -t $1
else
    echo "lolololol"
    tmux new-session -s $1
fi
