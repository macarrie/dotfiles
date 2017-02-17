## Arch linux install steps

* Boot into live archiso
* Set azerty keymap
```bash
% loadkeys fr
```

### Disk setup

* Create partitions/swap and mount them in /mnt

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
% pacman -S git ansible python2-passlib
% git clone https://github.com/macarrie/dotfiles
% cd dotfiles
```
* Edit `group_vars/all.yml`
* Run playbook
```bash
% make install
```
* (Optionnal) Install Infinality font scripts
```bash
% yaourt -S {cairo,freetype2,fontconfig}-infinality
```
* Reboot
* Add wallpapers to `~/Pictures` (create folder if needed)
* Set GTK theme with `lxappearance`
* Meow
* Prout


## TODO
* UEFI
* BTRFS ou ZFS
* LUKS
