#!/bin/bash

echo "Copying zshrc"
cp -v ~/dotfiles/.zshrc ~/.zshrc
echo

echo "Copying vimrc"
cp -v ~/dotfiles/.vimrc.local ~/.vimrc.local
echo

echo "Copying scripts"
cp -v -r ~/dotfiles/scripts ~/
echo

echo "Copying i3 config"
cp -v -r ~/dotfiles/.i3 ~/
cp -v ~/dotfiles/.i3blocks.conf ~/
echo

echo "Copying fonts"
cp -v -r ~/dotfiles/.fonts ~/
fc-cache -fv
echo
