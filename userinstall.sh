#!/bin/bash

usage() {
    echo "Usage: No arguments required"
}

all() {
    # Install yaourt as non-root before installing packages
    installYaourt

    # Install packages
    /home/${USER}/dotfiles/install_packages.sh

    # Setup cron jobs
    setupCronJobs

    # Setup git identity
    configureGit

    # Setup default shell
    setupShell

    # Deploy config
    sh deploy.sh
    createRootLinks
}

installYaourt() {
    # Install yaourt
    echo "Installing yaourt"
    current_dir=`pwd`
    mkdir ~/tmp
    cd ~/tmp
    git clone https://aur.archlinux.org/package-query.git
    cd package-query
    makepkg -si
    cd ..
    git clone https://aur.archlinux.org/yaourt.git
    cd yaourt
    makepkg -si
    cd ..
    cd ${current_dir}
}


createRootLinks() {
    echo "Creating links for root config"
    # ZSH
    sudo ln -s /home/${USER}/.oh-my-zsh /root/.oh-my-zsh
    sudo ln -s /home/${USER}/.zshrc /root/.zshrc
    # Vim
    sudo ln -s /home/${USER}/.vimrc /root/.vimrc
}

setupCronJobs() {
    echo "Setting up cron jobs"
    echo "*/15 * * * * DISPLAY=:0.0 /home/${USER}/scripts/random_wallpaper.sh" > /tmp/cronjob.txt
    sudo crontab -u ${USER} /tmp/cronjob.txt
}

configureGit() {
    echo "Git setup"
    read -p "Enter git user email: " GIT_MAIL
    git config --global user.email "$GIT_MAIL"
    read -p "Enter git user name: " GIT_USERNAME
    git config --global user.name "$GIT_USERNAME"
    git config --global push.default upstream
}

setupShell() {
    echo "Changing default shell"
    echo "Shell list: "
    chsh -l
    echo "----------"
    chsh
}


# Procede installation
if [ $# -ne 0 ]
then
    usage
    exit 1
else
    all
fi
