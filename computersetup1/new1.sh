#format and mount the three partitions, boot, root, swap
pacman -Sy
pacstrap /mnt base linux linux-firmware intel-ucode efibootmgr networkmanager openssh nano
genfstab -U /mnt >> /mnt/etc/fstab
