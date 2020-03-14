#!/bin/sh
dd if=/dev/zero of=$1 bs=1M count=1024
sleep 1
printf "g\nn\n\n\n+256M\nt\n\n1\nn\n\n\n\nw\n" | fdisk $1
sleep 1
echo $1"p1"
mkfs.fat -F32 $1"p1"
sleep 1
echo $1"p2"
mkfs.ext4 $1"p2"
