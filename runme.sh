#!/bin/sh
cd ~/git-repos;git clone https://aur.archlinux.org/yay-bin
cd ~/git-repos/yay-bin;makepkg -si --noconfirm
cd
yay -S icdiff --noconfirm
yay -S create_ap-git --noconfirm
yay -S ttf-ms-fonts --noconfirm
yay -S ttf-mac-fonts --noconfirm
yay -S st --noconfirm
echo "exec openbox-session" > ~/.xinitrc
cat ~/bash_profile_addendum.sh >> ~/.bash_profile

