pacstrap /mnt base networkmanager nano man-db man-pages texinfo openssh reflector git
genfstab -U /mnt >> /mnt/etc/fstab
reflector --sort rate --country us > /mnt/etc/pacman.d/mirrorlist
