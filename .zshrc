# Ignore duplicates in history
setopt HIST_IGNORE_DUPS

# Vi mode
    # Update on keymap change
    function zle-keymap-select() {
        zle reset-prompt
        zle -R
    }

    bindkey -v
    zle -N zle-keymap-select

    bindkey '^P' up-history
    bindkey '^N' down-history

    function vi_mode_prompt() {
        echo "${${KEYMAP/vicmd/$MODE_INDICATOR}/(main|viins)/}"
    }

    # if mode indicator wasn't setup by theme, define default
    if [[ "$MODE_INDICATOR" == "" ]]; then
      MODE_INDICATOR="<<<"
    fi
    if [[ "$RPS1" == "" && "$RPROMPT" == "" ]]; then
        RPROMPT='$(vi_mode_prompt)'
    fi

# Prompt

    # Git

    GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}\uE0A0 "
    GIT_PROMPT_SUFFIX="%{$reset_color%}"
    GIT_PROMPT_DIRTY="%{$fg[red]%}!"

    function git_branch() {
        echo `git branch 2> /dev/null | sed -n 's/* \(\w\)/\1/p'`
    }

    function git_is_dirty() {
        git status &> /dev/null
        if [ $? -eq 0 ]
        then
            echo $GIT_PROMPT_DIRTY
        else
            echo ""
        fi
    }

    function git_prompt() {
        if [ -d .git ]
        then
            echo "on %{$fg[magenta]%}\uE0A0$(git_branch)$(git_is_dirty)%{$reset_color%}"
        fi
    }

    autoload -Uz colors && colors
    setopt prompt_subst

    color="cyan"
    if [ "$USER" = "root" ]
    then
        color="red" 
    fi

    function identifier() {
        echo "%{$fg_bold[$color]%}%n@%m"
    }

    function current_dir() {
        echo "%{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%}"
    }

    function hour() {
        echo "%{$fg_bold[red]%}%*%{$reset_color%}"
    }

    RPROMPT='$(vi_mode_prompt) $(hour)'
    PROMPT='
$(identifier): $(current_dir) $(git_prompt)
%# '

# EXPORTS
    export EDITOR=vim
    export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$HOME/.local/bin"
    export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
    export RAILS_LOGGER='default'

# ALIAS
    alias sudo='_'
    # Tmux
    alias tmux='tmux -2'
    alias t='tmux'
    alias ta='tmux attach -t'
    alias ts='tmux new-session -s'
    alias tl='tmux list-sessions'

    # Git
    alias g='git'
    alias ga='git add'
    alias gb='git branch'
    alias gc='git commit -v'
    alias gcm='git checkout master'
    alias gco='git checkout'
    alias gd='git diff'
    alias gl='git pull'
    alias glo='git log --oneline --decorate --color'
    alias glog='git log --oneline --decorate --color --graph'
    alias gp='git push'
    alias grb='git rebase'
    alias grbi='git rebase -i'
    alias grbm='git rebase master'
    alias gst='git status'
    alias gsta='git stash'

    # Dir utils
    alias lsa='ls -lah'
    alias l='ls -lah'
    alias ll='ls -lh'
    alias la='ls -lAh'
    alias mkdir='mkdir -pv'
    alias rm='rm -I'
    alias cp='cp -v'
    alias ..='cd ..'
    alias ...='cd ../../../'
    alias ....='cd ../../../../'
    alias .....='cd ../../../../'
    
    # File search
    alias grep='grep --color=auto'

# Colored man pages
man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}

# Terminal startup
if [[ ! $TMUX ]]
then
    tmux attach -t tmp
fi
