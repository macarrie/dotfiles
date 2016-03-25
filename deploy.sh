#!/bin/bash

echo "Linking zshrc"
ln -s /home/${USER}/dotfiles/.zshrc /home/${USER}/.zshrc
rm /home/${USER}/.oh-my-zsh/themes/amuse.zsh-theme
ln -s /home/${USER}/dotfiles/amuse.zsh-theme /home/${USER}/.oh-my-zsh/themes/amuse.zsh-theme
echo

echo "Deploying vim config"
git clone https://github.com/VundleVim/Vundle.vim.git --depth=1 /home/${USER}/.vim/bundle/Vundle.vim
ln -s /home/${USER}/dotfiles/.vimrc /home/${USER}/.vimrc
vim +PluginInstall +qall
mkdir ~/.vimtmp
echo

echo "Linking scripts folder"
ln -s /home/${USER}/dotfiles/scripts /home/${USER}/scripts
echo

echo "Linking dunstrc"
if [ ! -e /home/${USER}/.config/dunst/ ]
then
	mkdir -p /home/${USER}/.config/dunst
fi

ln -s /home/${USER}/dotfiles/dunstrc /home/${USER}/.config/dunst/dunstrc
echo

echo "Linking i3 config"
ln -s /home/${USER}/dotfiles/.i3blocks.conf /home/${USER}/.i3blocks.conf
ln -s /home/${USER}/dotfiles/.i3 /home/${USER}/.i3
echo

echo "Copying fonts"
cp -v -r /home/${USER}/dotfiles/.fonts /home/${USER}/
fc-cache -fv
echo
