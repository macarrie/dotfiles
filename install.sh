#!/bin/bash

usage() {
	echo "Usage: No arguments required"
}

all() {
	# Install packages
    sudo /home/${USER}/dotfiles/install_packages.sh

    # Setup cron jobs
    setupCronJobs

	# Deploy config
	sh deploy.sh
	createRootLinks
}

createRootLinks() {
	# ZSH
	ln -s /home/${USER}/.oh-my-zsh /root/.oh-my-zsh
	ln -s /home/${USER}/.zshrc /root/.zshrc
	# Vim
	ln -s /home/${USER}/.vimrc /root/.vimrc
}

setupCronJobs() {
	echo "*/15 * * * * DISPLAY=:0.0 /home/${USER}/scripts/random_wallpaper.sh" > /tmp/cronjob.txt
	sudo crontab -u ${USER} /tmp/cronjob.txt
}


# Procede installation
if [ $# -ne 0 ]
then
	usage
	exit 1
else
    all
fi
