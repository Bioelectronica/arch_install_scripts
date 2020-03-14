pacman -Sy
mount /dev/mmcblk0p2 /mnt
mkdir /mnt/boot
mount /dev/mmcblk0p1 /mnt/boot
pacstrap /mnt base base-devel linux linux-firmware networkmanager nano man-db man-pages texinfo openssh reflector git
genfstab -U /mnt >> /mnt/etc/fstab
