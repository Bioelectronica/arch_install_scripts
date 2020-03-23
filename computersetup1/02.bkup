S1="$1"
S2="p2"
TARGET="$S1$S2"
bootctl --path=/boot install 
cat - > /boot/loader/loader.conf << EOF
default arch
EOF
cat - > /boot/loader/entries/arch.conf << EOF
title Bioelectronica
linux /vmlinuz-linux
initrd /intel-ucode.img
initrd /initramfs-linux.img
options root=$TARGET rw quiet
EOF
systemctl enable sshd
systemctl enable NetworkManager
printf "Welcome1mooredna\nWelcome1mooredna\n" | passwd
