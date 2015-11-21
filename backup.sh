#!/bin/bash

echo "Copying zshrc"
cp -v ~/.zshrc ~/dotfiles
echo

echo "Copying vimrc"
cp -v ~/.vimrc.local ~/dotfiles
echo

echo "Copying scripts"
cp -v -r ~/scripts ~/dotfiles
echo

echo "Copying i3 config"
cp -v -r ~/.i3 ~/dotfiles
cp -v ~/.i3blocks.conf ~/dotfiles/.i3blocks.conf
echo

echo "Copying fonts"
cp -v -r ~/.fonts ~/dotfiles
echo
