# Launch tmux at startup
if which tmux &> /dev/null
then
    tmux attach -d || tmux new-session
    tmux run-shell ~/.tmux/plugins/tmux-resurrect/scripts/restore.sh
fi
