#!/bin/sh
#------------------------------------------------------------- yay
cd ~/git-repos;git clone https://aur.archlinux.org/yay-bin
cd ~/git-repos/yay-bin;makepkg -si --noconfirm
cd
yay -S icdiff --noconfirm
yay -S create_ap-git --noconfirm


#------------------------------------------------------------- GUI
yay -S ttf-ms-fonts --noconfirm
yay -S ttf-mac-fonts --noconfirm
yay -S st --noconfirm
echo "exec openbox-session" > ~/.xinitrc
cat ~/bash_profile_addendum.sh >> ~/.bash_profile

 xorg xorg-xinit xterm openbox ttf-dejavu ttf-liberation tint2 network-manager-applet
arch-chroot /mnt pacman -S tk pcmanfm gpicview mupdf pavucontrol pulseaudio tigervnc chromium guvcview --noconfirm
cp rc.xml /mnt/etc/xdg/openbox/
cp menu.xml /mnt/etc/xdg/openbox/
cp tint2rc /mnt/etc/xdg/tint2/
echo "tint2 &" >> /mnt/etc/xdg/openbox/autostart
echo "nm-applet &" >> /mnt/etc/xdg/openbox/autostart

#------------------------------------------------------------- data science
pacman -S qt5-base hdf5 python-h5py ipython opencv --noconfirm
pacman -S python-pandas python-pytables python-matplotlib --noconfirm
pacman -S python-seaborn python-scikit-learn jupyter-notebook --noconfirm
pacman -S python-pyserial arduino-docs arduino-avr-core arduino --noconfirm
