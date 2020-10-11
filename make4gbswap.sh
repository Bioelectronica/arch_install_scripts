#!/bin/sh
dd if=/dev/zero of=/swapfile bs=1M count=4096 status=progress
chmod 600 /swapfile
swapon /swapfile
echo "/swapfile none swap defaults 0 0" >> /etc/fstab

