pacstrap /mnt base base-devel linux linux-firmware networkmanager nano man-db man-pages texinfo openssh reflector git
genfstab -U /mnt >> /mnt/etc/fstab
