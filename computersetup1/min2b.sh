localectl set-keymap us
timedatectl set-ntp true
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
