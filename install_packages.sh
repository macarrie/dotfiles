PACKAGE_MANAGER="yaourt "
UPDATE="$PACKAGE_MANAGER -Syu"
INSTALL="$PACKAGE_MANAGER -S --noconfirm"
REMOVE="$PACKAGE_MANAGER -R"

all() {
    # Upgrade packages
    $UPDATE

    # Install packages
    installXorg
    installVirtualboxSpecifics
    installDev
    installUtilities
    #installLatex
    installWeb
    installDesktop
    installThemes
    installFileTools
    installMedias
}

installXorg() {
    # X server
    $INSTALL xorg-server xorg-server-utils xorg-xinit
    # Access x clipboard
    $INSTALL xclip
    # xautolock
    $INSTALL xautolock
}

installVirtualboxSpecifics() {
    # Not needed for regular install
    # Virtualbox guest additions
    $INSTALL virtualbox-guest-utils
    # Arch specific
    $INSTALL virtualbox-guest-modules-arch
}

installUtilities() {
    # Synaptics drivers
    $INSTALL xf86-input-synaptics
    # Sound
    $INSTALL alsa-utils
    # Network
    $INSTALL networkmanager network-manager-applet
    sudo systemctl enable NetworkManager.service
    # System stats
    $INSTALL sysstat
    # Battery stats
    $INSTALL acpi
    # Cron jobs handler
    $INSTALL cronie
    sudo systemctl enable cronie.service
    # Notifications
    $INSTALL libnotify dunst
    # Multi-monitor utility
    $INSTALL xrandr arandr
    # URxvt
    $INSTALL rxvt-unicode-256xresources
    # htop
    $INSTALL htop
}

installDev() {
    # Python pip
    $INSTALL python-pip
    # Zsh
    $INSTALL zsh
    # Vim
    $INSTALL vim
    # Tmux
    $INSTALL tmux
    # ACK
    $INSTALL ack
}

installLatex() {
    # Install LaTeX basic packages
    $INSTALL texlive-most
}

installWeb() {
    # SSL
    $INSTALL openssl
    # Fetching utilities
    $INSTALL curl wget
    # Chromium
    $INSTALL chromium
}

installDesktop() {
    # i3 WM
    $INSTALL i3-gaps i3lock i3blocks
    # Rofi
    $INSTALL rofi
    # Unclutter for hiding mouse
    $INSTALL unclutter
    #i3lock wrapper script dependency
    $INSTALL bc
    # Basic compositing
    $INSTALL compton
}

installThemes() {
    # feh for setting background
    $INSTALL feh
    # Take screenshots
    $INSTALL scrot
    # Image manipulation
    $INSTALL imagemagick
    # Fonts
    $INSTALL otf-inconsolata-powerline-git
    $INSTALL ttf-impallari-cabin-font
    $INSTALL ttf-font-awesome
    $INSTALL terminus-font
    $INSTALL ephifonts-no-helvetica
    # Font rendering lib
    $INSTALL --confirm fontconfig-infinality
    $INSTALL --confirm freetype2-infinality
    # GTK Theme utility
    $INSTALL lxappearance
    # Paper icon theme
    $INSTALL --confirm paper-icon-theme-git
    # GTK Arc theme
    $INSTALL  --confirm gtk-theme-arc
}

installFileTools() {
    # Nautilus
    $INSTALL nautilus
    # PDF Viewer
    $INSTALL evince
    # Zip utility
    $INSTALL unzip
    # Versionning systems
    $INSTALL git subversion
}

installMedias() {
    $INSTALL vlc
    $INSTALL kodi
    $INSTALL spotify-stable
}

all
