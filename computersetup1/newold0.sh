#!/bin/sh
MEMTOTAL=$(grep MemTotal /proc/meminfo | awk '{print $2}')
MEMTOTAL= expr $MEMTOTAL \* 2
echo $MEMTOTAL
dd if=/dev/zero of=$1 bs=1M count=1024
printf "g\nw\n" | fdisk $1
sleep 2
partprobe $1
sleep 2
printf "n\n\n\n+256M\nw\n" | fdisk $1
sleep 2
partprobe $1
sleep 2
printf "t\n\n1\nw\n" | fdisk $1
sleep 2
partprobe $1
sleep 2
#printf "n\n\n\n-"$MEMTOTAL"\nw\n" | fdisk $1
printf "n\n\n\n\nw\n" | fdisk $1
sleep 2
partprobe $1
sleep 2
#printf "n\n\n\n\nw\n" | fdisk $1
#sleep 2
#partprobe $1
#sleep 2
#printf "t\n\n19\nw\n" | fdisk $1
#sleep 2
#partprobe $1
#sleep 2
echo $1"p1"
mkfs.fat -F32 $1"p1"
echo $1"p2"
mkfs.ext4 $1"p2"
echo $1"p3"
mkswap $1"p3"
swapon $1"p3"
