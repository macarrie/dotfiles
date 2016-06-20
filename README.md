## Arch linux install steps

* Boot into live archiso
* Set azerty keymap
```bash
% loadkeys fr
```

### Disk setup

* Identify drives and create partitions. At least a root partition is needed, and swap is recommended
```bash
% lsblk
% cfdisk /dev/sdx
```
* Make root partition ext4 and swapon
```bash
% mkfs.ext4 /dev/sdxY
% mkswap /dev/sdxZ
% swapon /dev/sdxZ
```
* Mount root partition
```bash
% mount /dev/sdXY /mnt
```

### Base system installation

* Edit pacman mirror list
```bash
% vi /etc/pacman.d/mirrorlist
```
* Install system
```bash
% pacstrap -i /mnt base base-devel
```
* Generate fstab
```bash
% genfstab -p /mnt >> /mnt/etc/fstab
```
* Arch-root into freshly installed system
```bash
% arch-chroot /mnt /bin/bash
```
* Retrieve and execute install script
```bash
% cd
% pacman -S git
% git clone https://github.com/macarrie/dotfiles --branch arch
% cd dotfiles
% ./systeminstall.sh
```
* If on Wifi, install networkmanager before rebooting
```bash
% pacman -S networkmanager
```
* Reboot

### User setup
* Login as newly created user 
* If not on wired network, connect to Wifi
```bash
% sudo systemctl start NetworkManager.service
% nmtui
```
* Execute user install script
```bash
% cd dotfiles
% ./userinstall.sh
```
* Reboot
* Add wallpapers to `~/Pictures` (create folder if needed)
* Set GTK theme with `lxappearance`
* Meow
* Prout
