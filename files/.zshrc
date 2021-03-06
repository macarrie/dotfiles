# Setopts
    # don't beep on error
    setopt NO_BEEP

    # Directory handling
        # If you type foo, and it isn't a command, and it is a directory in your cdpath, go there
        setopt AUTO_CD

    # History
        HIST_FILE=~/.zsh_history

        # Allow multiple terminal sessions to all append to one zsh command history
        setopt APPEND_HISTORY

        # Share history between zsh instances
        setopt SHARE_HISTORY

        # Add comamnds as they are typed, don't wait until shell exit
        setopt INC_APPEND_HISTORY

        # Do not write events to history that are duplicates of previous events
        setopt HIST_IGNORE_DUPS

        # When searching history don't display results already cycled through twice
        setopt HIST_FIND_NO_DUPS

        # Remove extra blanks from each command line being added to history
        setopt HIST_REDUCE_BLANKS

    # Completion
        # Allow completion from within a word/phrase
        setopt COMPLETE_IN_WORD

        # When completing from the middle of a word, move the cursor to the end of the word
        setopt ALWAYS_TO_END

    # Correction
        # spelling correction for commands
        #setopt correct
        # spelling correction for arguments
        #setopt correctall

    # Expansion
        # Enable parameter expansion, command substitution, and arithmetic expansion in the prompt
        setopt PROMPT_SUBST

# Completion
    autoload -U compinit && compinit
    zmodload -i zsh/complist

    zstyle ':completion:*' completer _expand _complete _correct _approximate
    # Highlight current tab selected completion
    zstyle ':completion:*' menu select=2
    # Fallback to built in ls colors
    zstyle ':completion:*' list-colors ''
    # Case insensitive completion
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' '+l:|=* r:|=*'

# Prompt
    bindkey -e
    bindkey "\e[1~" beginning-of-line
	bindkey "\e[4~" end-of-line
	bindkey "\e[5~" beginning-of-history
	bindkey "\e[6~" end-of-history
	bindkey "\e[7~" beginning-of-line
	bindkey "\e[3~" delete-char
	bindkey "\e[2~" quoted-insert
	bindkey "\e[5C" forward-word
	bindkey "\e[5D" backward-word
	bindkey "\e\e[C" forward-word
	bindkey "\e\e[D" backward-word
	bindkey "\e[1;5C" forward-word
	bindkey "\e[1;5D" backward-word
	bindkey "\e[8~" end-of-line
	bindkey "\eOH" beginning-of-line
	bindkey "\eOF" end-of-line
	bindkey "\e[H" beginning-of-line
	bindkey "\e[F" end-of-line



    autoload -Uz colors && colors

    # Git

    function git_branch() {
        echo `git branch 2> /dev/null | sed -n 's/* \(\w\)/\1/p'`
    }

    function git_is_dirty() {
        if [[ `git status --porcelain` ]]
        then
            echo "%{$fg[red]%}(\u00B1)"
        else
            echo ""
        fi
    }

    function git_prompt() {
        if [ -d .git ]
        then
            echo "on %{$fg[magenta]%} $(git_branch)$(git_is_dirty)%{$reset_color%}"
        fi
    }

    # Prompt line

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
        echo "%{$fg_bold[red]%}%* %{$reset_color%}"
    }

    PROMPT='
$(identifier): $(current_dir) $(git_prompt)     $(hour)
%# '

# EXPORTS
    export EDITOR=vim
    export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$HOME/.local/bin:/usr/bin/vendor_perl:/usr/local/go/bin:$HOME/go/bin"

# ALIAS
    alias _='sudo'
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
    alias ls='ls --color=auto -p --group-directories-first'
    alias l='ls -lah'
    alias ll='ls -lh'
    alias la='ls -lAh'
    alias mkdir='mkdir -pv'
    alias rm='rm -I'
    alias cp='cp -v'
    alias mv='mv -v'
    alias -g ..='cd ..'
    alias -g ...='cd ../..'
    alias -g ....='cd ../../..'
    alias -g .....='cd ../../../..'
    alias cat='bat'
    function mkcd() {
        mkdir $1 && cd $1
    }

    # File search
    alias grep='grep --color=auto'

    # Yaourt
    alias remove_orphans='yay -Rns $(yay -Qtdq)'

    # Vim
    alias v='nvim'
    alias vi='vim -U NONE'
    alias vf='nvim $(fd . --hidden | fzf)'

    # fzf REPL
    function ff() {
        query=$(echo '' | fzf  --print-query --preview-window=up:99% --preview $1)
        echo $1 | sed "s/\(.*\){q}\(.*\)/\1$query\2/"
    }

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

# Source local zshrc modifs
if [ -f ~/.zshrc.local ]
then
    source ~/.zshrc.local
fi

# fzf
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
export FZF_DEFAULT_COMMAND="fd --hidden ."
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d . $HOME"

source ~/.zshrc.local

# Terminal startup
if [[ ! $TMUX ]]
then
    tmux attach -t tmp
fi
