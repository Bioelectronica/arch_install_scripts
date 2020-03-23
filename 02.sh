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
localectl set-keymap us
timedatectl set-ntp true
ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime 
hwclock --systohc
rm /etc/locale.gen
echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen
locale-gen
echo 'LANG=en_US.UTF-8' >> /etc/locale.conf
echo 'LC_ALL=en_US.UTF-8' >> /etc/locale.conf 
echo 'KEYMAP=us' >> /etc/vconsole.conf
useradd -mG wheel,users,audio,lp,optical,storage,video,power,uucp,lock -s /bin/bash saveguest
printf "Welcome1mooredna\nWelcome1mooredna\n" | passwd saveguest
useradd -m -s /bin/bash bioeuser1
printf "Welcome1mooredna\nWelcome1mooredna\n" | passwd bioeuser1
cp phone-home.service /etc/systemd/system
systemctl daemon-reload
systemctl enable phone-home
BLANK=""
su - bioeuser1 -s /bin/bash -c "cat /dev/zero | ssh-keygen -q -N $BLANK"
YES="yes\n"
su - bioeuser1 -s /bin/bash -c "printf $YES | ssh 104.210.57.240"
pacman -S sshpass
su - bioeuser1 -s /bin/bash -c "sshpass -p Welcome1mooredna ssh-copy-id 104.210.57.240"
