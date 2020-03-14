pacman -S efibootmgr --noconfirm
bootctl --path=/boot install 
cat - > /boot/loader/loader.conf << EOF
default arch
EOF
pacman -S intel-ucode --noconfirm
cat - > /boot/loader/entries/arch.conf << EOF
title Bioelectronica
linux /vmlinuz-linux
initrd /intel-ucode.img
initrd /initramfs-linux.img
options root=/dev/mmcblk0p2 rw quiet
EOF
ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime 
hwclock --systohc
rm /etc/locale.gen
echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen
locale-gen
echo 'LANG=en_US.UTF-8' > /etc/locale.conf
echo 'KEYMAP=us' > /etc/vconsole.conf
echo 'acr1' > /etc/hostname
echo 'export LANG=en_US.UTF-8' >> /etc/profile 
echo 'export LC_ALL=en_US.UTF-8' >> /etc/profile
localectl set-locale LANG=en_US.UTF-8
localectl set-keymap us
systemctl enable sshd
systemctl enable NetworkManager
printf "Welcome1mooredna\nWelcome1mooredna\n" | passwd
