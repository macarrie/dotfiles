#!/bin/bash

echo "Copying zshrc"
cp -v ~/dotfiles/.zshrc ~/.zshrc
rm ~/.oh-my-zsh/themes/amuse.zsh-theme
ln -s ~/dotfiles/amuse.zsh-theme ~/.oh-my-zsh/themes/amuse.zsh-theme
echo

echo "Copying vimrc"
cp -v ~/dotfiles/.vimrc.local ~/.vimrc.local
cp -v ~/dotfiles/.vimrc.before.local ~/.vimrc.before.local
echo

echo "Copying scripts"
cp -v -r ~/dotfiles/scripts ~/
echo

echo "Coying dunstrc"
cp -v ~/dotfiles/dunstrc ~/.config/dunst/
echo

echo "Copying i3 config"
cp -v -r ~/dotfiles/.i3 ~/
cp -v ~/dotfiles/.i3blocks.conf ~/
echo

echo "Copying fonts"
cp -v -r ~/dotfiles/.fonts ~/
fc-cache -fv
echo
