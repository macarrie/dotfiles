#!/bin/bash

APT="apt-get --yes -s"
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
	#installZsh
	#installSpf13

	# Deploy config
	sh deploy.sh

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
	$INSTALL chromium-browser
	# Chromium flash plugin
	$INSTALL pepperflashplugin-nonfree
}

installDesktop() {
	# i3 WM
	$INSTALL i3 i3lock i3status
	# Unclutter for hiding mouse
	$INSTALL unclutter
}

installThemes() {
	# feh for setting background
	$INSTALL feh
	# Take screenshots
	$INSTALL scrot
	# Image manipulation
	$INSTALL imagemagick
	# GTk Theme utility
	$INSTALL lxappearance
	#TODO
	#moka-icon-theme
	#numix-gtk-theme
	#arc-theme
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
