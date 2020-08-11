#!/bin/sh
T="/dev/nvme0n1"
P="p"
A=$T"$P"1
B=$T"$P"2
C=$T"$P"3
D=$T"$P"4
E=$T"$P"5
X="/sys/class/dmi/id/product_uuid"
parted -s $T mklabel gpt 
parted -s $T mkpart primary fat32 1MiB 261MiB
parted -s $T set 1 esp on
parted -s $T mkpart primary ext4 261MiB 98304MiB
parted -s $T mkpart non-fs 98304MiB 114688MiB
parted -s $T mkpart primary linux-swap 114688MiB 180224MiB
parted -s $T mkpart primary ext4 180224MiB 100%
partprobe $T
sleep 0.1
mkfs.fat -F32 $A
sleep 0.1
mkfs.ext4 $B
sleep 0.1
cryptsetup luksFormat $C
cryptsetup luksAddKey $C $X
cryptsetup luksOpen $C gtr
mkfs.ext4 /dev/mapper/gtr
sleep 0.1
mkswap $D
sleep 0.1
mkfs.ext4 $E
#------------------------------------------------------------- make chroot
pacman -Sy reflector
reflector --sort rate --country us > mirrorlist
cp mirrorlist /etc/pacman.d/mirrorlist
pacman -Sy
mount $B /mnt
mkdir /mnt/boot
mount $A /mnt/boot
pacstrap /mnt base base-devel linux linux-firmware intel-ucode efibootmgr networkmanager openssh nano man-db man-pages git sudo reflector xorg xorg-xinit xterm openbox ttf-dejavu ttf-liberation tint2 network-manager-applet
# note that reflector includes python
genfstab -U /mnt >> /mnt/etc/fstab
echo "gtr $C $X luks" >> /mnt/etc/crypttab
chmod 400 /mnt/etc/crypttab
echo "/dev/mapper/gtr /home/saveguest/git-repos ext4 rw,sync,nofail 0 0" >> /mnt/etc/fstab
cp mirrorlist /mnt/etc/pacman.d/mirrorlist
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
options root=$B rw quiet
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
arch-chroot /mnt timedatectl set-ntp 1
arch-chroot /mnt systemctl enable sshd
arch-chroot /mnt systemctl enable NetworkManager
passwd --root /mnt root
mkdir /mnt/data
mount $E /mnt/data
chmod 777 /mnt/data
echo "$E /data ext4 rw,sync,nofail 0 0" >> /mnt/etc/fstab
cp phone-home.service /mnt/etc/systemd/system/
cp hosts /mnt/etc/hosts
cp rc.xml /mnt/etc/xdg/openbox/
cp menu.xml /mnt/etc/xdg/openbox/
cp tint2rc /mnt/etc/xdg/tint2/
echo "tint2 &" >> /mnt/etc/xdg/openbox/autostart
echo "nm-applet &" >> /mnt/etc/xdg/openbox/autostart
arch-chroot /mnt pacman -S tk wget vim vi htop nload ncdu tmux iotop dosfstools parted --noconfirm
arch-chroot /mnt pacman -S pcmanfm gpicview mupdf pavucontrol pulseaudio tigervnc chromium guvcview --noconfirm
#------------------------------------------------------------- add users
arch-chroot /mnt useradd -mG wheel,users,audio,lp,optical,storage,video,power,uucp,lock -s /bin/bash saveguest
mkdir /mnt/home/saveguest/git-repos
mount /dev/mapper/gtr /mnt/home/saveguest/git-repos
arch-chroot /mnt chown saveguest /home/saveguest/git-repos
arch-chroot /mnt chgrp saveguest /home/saveguest/git-repos
cp bash_profile_addendum.sh /mnt/home/saveguest/
cp runme.sh /mnt/home/saveguest/
chmod 777 /mnt/home/saveguest/bash_profile_addendum.sh
chmod 777 /mnt/home/saveguest/runme.sh
arch-chroot /mnt useradd -m -s /bin/bash bioeuser1
#------------------------------------------------------------- data science
arch-chroot /mnt pacman -S qt5-base hdf5 python-h5py ipython opencv --noconfirm
arch-chroot /mnt pacman -S python-pandas python-pytables python-matplotlib --noconfirm
arch-chroot /mnt pacman -S python-seaborn python-scikit-learn jupyter-notebook --noconfirm
arch-chroot /mnt pacman -S python-pyserial arduino-docs arduino-avr-core arduino --noconfirm
# manual steps after are as follows:
# set the hostname
# reboot
# login as root
# set password for saveguest and bioeuser1
# EDITOR=nano visudo pick the NOPASSWD option
# look at this file to file to get the ssh instructions
# su bioeuser1
# ssh-keygen
# ssh-copy-id 104.210.57.240
# edit /etc/systemd/system/phone-home.service for port number
# systemctl daemon-reload
# systemctl enable phone-home
# reboot and then make sure phone home works by using be2 to reverse tunnel in
# login as saveguest and execute runme
