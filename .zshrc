# Ignore duplicates in history
setopt HIST_IGNORE_DUPS

# Vi mode
    bindkey -v
    bindkey '^P' up-history
    bindkey '^N' down-history

    function vi_mode_prompt_info() {
      echo "${${KEYMAP/vicmd/$MODE_INDICATOR}/(main|viins)/}"
    }

    # if mode indicator wasn't setup by theme, define default
    if [[ "$MODE_INDICATOR" == "" ]]; then
      MODE_INDICATOR="%{$fg_bold[red]%}<%{$fg[red]%}<<%{$reset_color%}"
    fi
    if [[ "$RPS1" == "" && "$RPROMPT" == "" ]]; then
      RPS1='$(vi_mode_prompt_info)'
    fi

    GIT_PROMPT_PREFIX="\uE0A0 "
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
        fi
    }

    function git_prompt_info() {
        if [ -d .git ]
        then
            echo "$GIT_PROMPT_PREFIX$(git_branch)$(git_is_dirty)$GIT_PROMPT_SUFFIX"
        fi
    }

# Theme
    autoload -Uz colors && colors
    setopt prompt_subst

    color="cyan"
    if [ "$USER" = "root" ]
    then
        color="red" 
    fi

    PROMPT='
%{$fg_bold[$color]%}%n@%m: %{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%} on %{$fg[magenta]%} $(git_prompt_info)   %{$fg_bold[red]%}%*%{$reset_color%}
%# '

# EXPORTS
    export EDITOR=vim
    export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$HOME/.local/bin"
    export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
    export RAILS_LOGGER='default'

# ALIAS
    # Tmux
    alias tmux='tmux -2'
    alias tls='tmux ls'
    alias tma='tmux a'

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

    # Other
    alias mkdir='mkdir -p'

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
