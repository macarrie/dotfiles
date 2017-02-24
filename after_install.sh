#!/bin/bash

startAndEnable() {
    sudo -u root bash << EOF
    echo -e "\tEnabling $1 service"
    systemctl enable $1
    echo -e "\tStarting $1 service"
    systemctl start $1
EOF
}

install() {
    yes | yaourt -S $1
}

main() {
	# Enable services
	echo -e "\n\nEnable and start services"
    startAndEnable dhcpcd
    startAndEnable NetworkManager
    startAndEnable ntpd
    startAndEnable cronie

	# Accept infinality gpg keys
	echo -e "\n\nGet infinality gpg keys"
    gpg --recv-keys C1A60EACE707FDA5

	# Install infinality packages
	echo -e "\n\nInstall infinality packages"
    install freetype2-infinality
    install fontconfig-infinality
    install cairo-infinality
}

main
