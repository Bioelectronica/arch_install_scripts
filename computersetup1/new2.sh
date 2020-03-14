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
systemctl enable sshd
systemctl enable NetworkManager
printf "Welcome1mooredna\nWelcome1mooredna\n" | passwd
