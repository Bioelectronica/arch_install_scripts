printf "g\nn\n\n\n+512M\nt\n1\nn\n\n\n-64G\nn\n\n\n\nt\n\n19\nw\n" | fdisk /dev/nvme0n1
mkfs.fat -F32 /dev/nvme0n1p1
mkfs.ext4 /dev/nvme0n1p2
mkswap /dev/nvme0n1p3
swapon /dev/nvme0n1p3
pacman -Sy
mount /dev/nvme0n1p2 /mnt
mkdir /mnt/boot
mount /dev/nvme0n1p1 /mnt/boot
pacstrap /mnt base base-devel linux linux-firmware networkmanager nano man-db man-pages texinfo openssh reflector git
genfstab -U /mnt >> /mnt/etc/fstab
