#!/bin/sh
parted -s $1 mklabel gpt 
parted -s $1 mkpart primary fat32 1MiB 261MiB
parted -s $1 set 1 esp on
parted -s $1 mkpart primary ext4 261MiB 100%
partprobe $1
sleep 0.1
echo $1"p1"
mkfs.fat -F32 $1"p1"
sleep 0.1
echo $1"p2"
mkfs.ext4 $1"p2"
pacman -Sy
mount $1p2 /mnt
mkdir /mnt/boot
mount $1p1 /mnt/boot
pacstrap /mnt base linux linux-firmware intel-ucode efibootmgr networkmanager openssh nano
genfstab -U /mnt >> /mnt/etc/fstab
cd
cp -r arch_install_scripts /mnt/root
