#!/bin/sh
parted -s $1 mklabel gpt 
parted -s $1 mkpart primary fat32 1MiB 261MiB
parted -s $1 set 1 esp on
parted -s $1 mkpart primary ext4 261MiB 100%
partprobe $1
sleep 0.1
echo $1"p1"
mkfs.fat -F32 $1"p1"
sleep 0.1
echo $1"p2"
mkfs.ext4 $1"p2"
