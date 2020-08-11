#!/bin/sh
cd ~/git-repos;git clone https://aur.archlinux.org/yay-bin
cd ~/git-repos/yay-bin;makepkg -si --noconfirm
yay -S icdiff --noconfirm
yay -S create_ap-git --noconfirm
yay -S ttf-ms-fonts --noconfirm
yay -S ttf-mac-fonts --noconfirm
