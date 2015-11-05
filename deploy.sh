#!/bin/bash

echo "Copying zshrc"
echo "setxkbmap -option caps:escape" >> ~/.zshrc
echo "export EDITOR=vim" >> ~/.zshrc
echo

echo "Copying vimrc"
cp -v ~/dotfiles/.vimrc.local ~/.vimrc.local
echo

echo "Copying scripts"
cp -v -r ~/dotfiles/scripts ~/
echo

echo "Copying i3 config"
cp -v -r ~/dotfiles/.i3 ~/
cp -v ~/dotfiles/.i3status.conf ~/
echo

echo "Copying fonts"
cp -v -r ~/dotfiles/.fonts ~/
echo
