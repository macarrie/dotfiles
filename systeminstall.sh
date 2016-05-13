#!/bin/bash

usage() {
    echo "Usage: No arguments required"
}

all() {
    setupHostname
    setupLocale
    setupClock
    setupRamdisk
    installBootloader
    createUser
}

setupHostname() {
    echo "Setting up hostname"
    read -p "Enter hostname: " HOSTNAME
    echo $HOSTNAME > /etc/hostname
    sed -i 's/.*localhost\.localdomain.*localhost/&\t$HOSTNAME/' /etc/hosts
    echo -e "\n"
}

setupLocale() {
    echo "Setting up locales"
    ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime
    sed -i 's/#en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen
    locale-gen
cat > /etc/vconsole.conf <<EOF
KEYMAP=fr
FONT=Lat2-Terminus16
EOF
    echo "LANG=en_US.UTF-8" > /etc/locale.conf
    export LANG=en_US.UTF-8
    echo -e "\n"
}

setupClock() {
    echo "Setting up clock"
    hwclock --systohc --localtime
    echo -e "\n"
}

setupRamdisk() {
    echo "Setting up ramdisk"
    mkinitcpio -p linux
    echo -e "\n"
}

installBootloader() {
    echo "Installing bootloader"
    pacman -S grub os-prober
    lsblk
    read -p "Enter disk to install bootloader on (e.g. /dev/sdX): " DISK
    grub-install $DISK
    grub-mkconfig -o /boot/grub/grub.cfg
    echo -e "\n"
}

createUser() {
    echo "Setting up root account"
    echo Enter root password: 
    passwd root

    echo "Creating user account"
    read -p "Enter username: " USERNAME
    useradd -m $USERNAME
    echo "Enter user password: "
    passwd $USERNAME

    echo "Adding user to wheel group"
    sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL' /etc/sudoers
    usermod -aG wheel $USERNAME
    echo -e "\n"
}

# Procede installation
if [ $# -ne 0 ]
then
    usage
    exit 1
else
    all
fi
