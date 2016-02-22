# Script adapted for a Kali Rolling install

* As root:

> adduser ${username}
> usermod -aG root ${username}

* As username

> git clone http://github.com/macarrie/dotfiles
> cd dotfiles
> sudo ./install.sh packages
> sudo reboot
> ./install.sh config

* Remove default notification-daemon to replace it with dunst

> sudo apt-get remove notification-daemon
> sudo reboot

* Add wallpapers to ~/Pictures
