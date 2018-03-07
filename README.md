## Arch linux install steps

* Boot into live archiso
* Set azerty keymap
```bash
% loadkeys fr
```

### Disk setup

* Create partitions/swap and mount them in /mnt
In btrfs:
```bash
## Partition disk
cfdisk /dev/sdX

## Mount partitions
mkfs.vfat -F 32 $boot_partition
mkfs.btrfs $root_partition

## Mount btrfs root volume
mkdir /mnt/btrfs-vol
mount -o defaults,relatime,discard,ssd,nodev,nosuid $root_partition /mnt/btrfs-vol

## Create subvolumes
mkdir -p /mnt/btrfs-vol/__snapshots
mkdir -p /mnt/btrfs-vol/__active
btrfs subvolume create /mnt/btrfs-vol/__active/root
btrfs subvolume create /mnt/btrfs-vol/__active/home

## Mount subvolumes
mkdir -p /mnt/btrfs-active
mount -o subvol=__active/root $root_partition /mnt/btrfs-active
mkdir -p /mnt/btrfs-active/home
mount -o subvol=__active/home $root_partition /mnt/btrfs-active/home

## Mount boot partition into __active/root btrfs subvolume
mkdir -p /mnt/btrfs-active/boot
mount $boot_partition /mnt/btrfs-active/boot
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
If btrfs install, install btrfs-progs as well
```bash
% pacstrap -i /mnt base base-devel btrfs-progs
```
* Generate fstab
```bash
% genfstab -U -p /mnt >> /mnt/etc/fstab
```
* Arch-root into freshly installed system
```bash
% arch-chroot ROOT_PARTITION /bin/bash
```
* Retrieve and execute install script
```bash
% cd
% pacman -S git ansible python2-passlib
% git clone https://github.com/macarrie/dotfiles
% cd dotfiles
```
* Edit `group_vars/all.yml`
* Enable Ansible logging (just in case) in /etc/ansible/ansible.cfg
* Run playbook
```bash
% make install
```
* Reboot
* Execute after install script in dotfiles folder
* Add wallpapers to `~/Pictures` (create folder if needed)
* Set GTK theme with `lxappearance`
* Meow
* Prout


## TODO
- LUKS
