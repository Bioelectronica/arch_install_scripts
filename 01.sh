#!/bin/sh
if [[ "$1" == "/dev/sd"* ]]; then P="";else P="p";fi
parted -s $1 mklabel gpt 
parted -s $1 mkpart primary fat32 1MiB 261MiB
parted -s $1 set 1 esp on
parted -s $1 mkpart primary ext4 261MiB 100%
partprobe $1
sleep 0.1
echo $1"$P"1
mkfs.fat -F32 $1"$P"1
sleep 0.1
echo $1"$P"2
mkfs.ext4 $1"$P"2
pacman -Sy
mount $1"$P"2 /mnt
mkdir /mnt/boot
mount $1"$P"1 /mnt/boot
pacstrap /mnt base base-devel linux linux-firmware intel-ucode efibootmgr networkmanager openssh nano man-db man-pages git sudo reflector
# note that reflector includes python
genfstab -U /mnt >> /mnt/etc/fstab
cd
cp -r arch_install_scripts /mnt/root
# manual step after is arch-chroot /mnt then goto install directory and sh 02.sh /dev/mmcblk0
