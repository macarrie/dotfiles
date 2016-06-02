#!/bin/bash
HOME=$HOME
DOTFILES=$HOME/dotfiles

create_link() {
    if [ $# -ne 1 ]
    then
        echo "create_link requires the path to be given as parameter"
    else
        # Check source existence
        if [ ! -e $DOTFILES/$1 ]
        then 
            # Source file doesn't exists, ERROR
            echo "Source file ($DOTFILES/$1) doesn't exist" >&2
        else
            # Source file exists
            # Check destination existence
            if [ -L $HOME/$1 ]
            then
                # Remove it if it is a symlink
                echo "WARNING: Symlink already exists. Symlink removed" >&2
                rm $HOME/$1
            else
                if [ -e $HOME/$1 ]
                then
                    echo "Existing $1 backuped to $1.bak"
                    mv $HOME/$1 $HOME/$1.bak
                fi
            fi

            # Creating symlink
            ln -s $DOTFILES/$1 $HOME/$1
            echo "$DOTFILES/$1 -> $HOME/$1"
        fi
    fi
}

echo "========== ZSH"
echo "=============================="
create_link ".zshrc"
create_link ".zprofile"
echo -e "\n"


echo "========== VIM"
echo "=============================="
git clone https://github.com/VundleVim/Vundle.vim.git --depth=1 $HOME/.vim/bundle/Vundle.vim
create_link ".vimrc"
vim +PluginInstall +qall
mkdir ~/.vimtmp
echo -e "\n"

echo "========== TMUX"
echo "=============================="
# Powerline
# Plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
create_link ".tmux.conf"
tmux kill-server
tmux new-session -s tmp -d
tmux run-shell $HOME/.tmux/plugins/tpm/bindings/install_plugins
echo -e "\n"


echo "========== SCRIPTS"
echo "=============================="
create_link "scripts"
echo -e "\n"


echo "========== DUNST"
echo "=============================="
if [ ! -e $HOME/.config/dunst/ ]
then
    mkdir -p $HOME/.config/dunst
fi
create_link ".config/dunst/dunstrc"
echo -e "\n"


echo "========== I3"
echo "=============================="
create_link ".i3"
create_link ".i3blocks.conf"
echo -e "\n"


echo "========== GTK FIX"
echo "=============================="
cp -v $DOTFILES/gtk3_fix.css $HOME/.config/gtk-3.0/gtk.css
echo -e "\n"

echo "========== XINITRC"
echo "=============================="
create_link ".xinitrc"
echo -e "\n"


echo "========== XRESOURCES"
echo "=============================="
create_link ".Xresources"
xrdb ~/.Xresources
echo -e "\n"


echo "========== YAOURT"
echo "=============================="
create_link ".yaourtrc"
echo -e "\n"
