# Script adapted for a Kali Rolling install

### As root:

``` bash
> setxkbmap fr
> adduser ${username}
> usermod -aG root ${username}
```

### As username

* Install packages

``` bash
> sudo ./install.sh packages
> sudo reboot
```

* Install user config (Oh-my-zsh + spf-13 + deploy dotfiles)

``` bash
> ./install.sh config
```

* Remove Gnome 3 default `notification-daemon` to replace it with `dunst`

``` bash
> sudo apt-get remove notification-daemon
> sudo reboot
```

* Add wallpapers to `~/Pictures`
* Set GTK theme with `lxappearance`
* Meow
* Prout
