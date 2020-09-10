#!/bin/sh
#------------------------------------------------------------- partition and format
T="/dev/mmcblk0"
P="p"
A=$T"$P"1
B=$T"$P"2
C=$T"$P"3
parted -s $T mklabel gpt 
parted -s $T mkpart primary fat32 1MiB 261MiB
parted -s $T set 1 esp on
parted -s $T mkpart primary linux-swap 261MiB 8096MiB
parted -s $T mkpart primary ext4 8096MiB 100%
partprobe $T
sleep 0.1
mkfs.fat -F32 $A
sleep 0.1
mkfs.ext4 $C
sleep 0.1
mkswap $B
#------------------------------------------------------------- mounts and make chroot
cp /root/arch_install_scripts/mirrorlist /etc/pacman.d/mirrorlist
pacman -Sy
mount $C /mnt
mkdir /mnt/boot
mount $A /mnt/boot
pacstrap /mnt base base-devel linux linux-firmware intel-ucode efibootmgr networkmanager openssh nano man-db man-pages git sudo reflector wget vim vi htop nload ncdu tmux iotop dosfstools parted nmap --noconfirm
# note that reflector includes python
genfstab -U /mnt >> /mnt/etc/fstab
cp /root/arch_install_scripts/mirrorlist /mnt/etc/pacman.d/mirrorlist
#------------------------------------------------------------- boot configuration
arch-chroot /mnt bootctl --path=/boot install 
cat - > /mnt/boot/loader/loader.conf << EOF
default arch
EOF
cat - > /mnt/boot/loader/entries/arch.conf << EOF
title Bioelectronica
linux /vmlinuz-linux
initrd /intel-ucode.img
initrd /initramfs-linux.img
options root=$C rw acpi=ht
EOF
#------------------------------------------------------------- localization settings
arch-chroot /mnt localectl set-keymap us
arch-chroot /mnt ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime 
arch-chroot /mnt hwclock --systohc
rm /mnt/etc/locale.gen
echo 'en_US.UTF-8 UTF-8' >> /mnt/etc/locale.gen
arch-chroot /mnt locale-gen
echo 'LANG=en_US.UTF-8' >> /mnt/etc/locale.conf
echo 'LC_ALL=en_US.UTF-8' >> /mnt/etc/locale.conf 
echo 'KEYMAP=us' >> /mnt/etc/vconsole.conf
#------------------------------------------------------------- misc for root
arch-chroot /mnt systemctl enable sshd
arch-chroot /mnt systemctl enable NetworkManager
cp *.service /mnt/etc/systemd/system/
cp /root/arch_install_scripts/hosts /mnt/etc/hosts
cp -r /root/arch_install_scripts /mnt/root/
chmod -R 777 /mnt/root/
#------------------------------------------------------------- add users
arch-chroot /mnt useradd -mG wheel,users,audio,lp,optical,storage,video,power,uucp,lock -s /bin/bash saveguest
mkdir /mnt/home/saveguest/git-repos
arch-chroot /mnt chown saveguest /home/saveguest/git-repos
arch-chroot /mnt chgrp saveguest /home/saveguest/git-repos
arch-chroot /mnt useradd -m -s /bin/bash bioeuser0
# manual steps after are as follows:
# arch-chroot /mnt
# set the hostname
# set password for root, saveguest, bioeuser0
# EDITOR=nano visudo pick the NOPASSWD option
# look at this file to file to get the ssh instructions
# su bioeuser1
# ssh-keygen
# ssh-copy-id 104.210.57.240
# edit /etc/systemd/system/phone-home.service for port number
# systemctl daemon-reload
# systemctl enable phone-home
# reboot and then make sure phone home works by using be2 to reverse tunnel in
# login as saveguest and execute runme.sh
