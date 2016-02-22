#!/bin/bash

APT="apt-get --yes"
UPDATE="apt-get update"
INSTALL="$APT install"
REMOVE="$APT remove"
ADDREPO="add-apt-repository --yes"

all() {

	# Upgrade packages
	upgradePackages

	# Install packages
	installUtilities
	installWeb
	installDesktop
	installThemes
	installMedias
	#installZsh
	#installSpf13

	# Deploy config
	sh deploy.sh
	createRootLinks

	# Remove unwanted packages
	cleanPackages
}

upgradePackages() {
	$UPDATE
	$APT upgrade
}

installUtilities() {
	# Battery stats
	$INSTALL acpi
	# Multi-monitor utility
	$INSTALL arandr
	# deb packages installer
	$INSTALL gdebi
	# Partition manager
	$INSTALL gparted gpart
	# Java 8
	$INSTALL oracle-java8-installer
	# Python package installer
	$INSTALL python-pip
	# apt GUI
	$INSTALL synaptic
	# Graphical terminal emulator/"multiplexer"
	$INSTALL terminator
	# Notifications lib
	$INSTALL libnotify-bin
	# Wireshark
	$INSTALL wireshark
	# tcpdump
	$INSTALL tcpdump
	# John The Ripper
	$INSTALL john
	# ACK
	$INSTALL ack-grep
	# htop
	$INSTALL htop
}

installLatex() {
	# Install LaTeX basic packages
	$INSTALL texlive-base
}

installWeb() {
	# SSL
	$INSTALL openssl
	$INSTALL curl
	# Chromium
	$INSTALL chromium
	# Chromium flash plugin
	$INSTALL pepperflashplugin-nonfree
}

installDesktop() {
	# i3 WM
	$INSTALL i3 i3lock i3status i3blocks
	# xautolock
	$INSTALL xautolock
	# Unclutter for hiding mouse
	$INSTALL unclutter
	#i3lock wrapper script dependency
	$INSTALL bc
}

installThemes() {
	# feh for setting background
	$INSTALL feh
	# Take screenshots
	$INSTALL scrot
	# Image manipulation
	$INSTALL imagemagick
	# GTK Theme utility
	$INSTALL lxappearance

	#moka-icon-theme
	$ADDREPO ppa:moka/stable
	$UPDATE
	$INSTALL moka-icon-theme
	#numix-gtk-theme

	#arc-theme
	cd /tmp
	wget http://download.opensuse.org/repositories/home:/Horst3180/xUbuntu_15.04/all/arc-theme-solid_1450051815.946cbf5_all.deb
	sudo gdebi arc-theme-solid_1450051815.946cbf5_all.deb
	cd -
}

installFileTools() {
	# PDF Viewer
	$INSTALL evince
	# File Browser
	$INSTALL nautilus
	# Dropbox integration
	$INSTALL nautilus-dropbox
	# Zip utility
	$INSTALL unzip
	# Versionning systems
	$INSTALL git subversion
}

installMedias() {
	$INSTALL vlc
	installKodi
	installSpotify
}

installKodi() {
	 # Kodi dependance
	 $INSTALL software-properties-common
	 $ADDREPO ppa:team-xbmc/ppa
	 $UPDATE
	 $INSTALL kodi
}

installSpotify() {
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
	echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
	$UPDATE
	$INSTALL spotify-client
}

installSpf13() {
	# Install vim
	$INSTALL vim
	# Get Spf13
	curl http://j.mp/spf13-vim3 -L -o - | sh
}

installZsh() {
	# Install zsh
	$INSTALL zsh
	# Install OhMyZsh
	sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

createRootLinks() {
	# ZSH
	ln -s /home/mat/.oh-my-zsh /root/.oh-my-zsh
	ln -s /home/mat/.zshrc /root/.zshrc
	# Vim
	ln -s /home/mat/.vimrc.local /root/.vimrc.local
}

cleanPackages() {
	$REMOVE abiword
	$REMOVE brasero
	$REMOVE firefox
	$REMOVE gimp
	$REMOVE libreoffice-calc
	$REMOVE libreoffice-math
	$REMOVE libreoffice-common
	$REMOVE libreoffice-core
	$REMOVE libreoffice-writer
	$REMOVE libreoffice-gtk
	$REMOVE pidgin
	$REMOVE thunderbird

	# Clean
	$APT autoremove
}

# Procede installation
all
