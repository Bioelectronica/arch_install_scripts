pacman -S xorg-server xorg-apps xorg-xinit openbox tint2 pavucontrol pulseaudio xfce4-terminal
pacman -S tk wget vim vi htop nload ncdu tmux iotop tigervnc network-manager-applet guvcview
pacman -S pcmanfm ristretto viewnior mupdf gedit light arandr
chmod u+s /usr/bin/light
pacman -S qt5-base hdf5 python-h5py ipython opencv
pacman -S python-pandas python-pytables python-matplotlib 
pacman -S python-seaborn python-scikit-learn jupyter-notebook
pacman -S python-pyserial arduino-docs arduino-avr-core
wget http://archive.virtapi.org/packages/a/arduino/arduino-1%3A1.8.9-1-x86_64.pkg.tar.xz
pacman -U arduino-1:1.8.9-1-x86_64.pkg.tar.xz
pacman -S ttf-ubuntu-font-family ttf-croscore ttf-liberation noto-fonts noto-fonts-cjk noto-fonts-emoji
#yay -S ttf-ms-fonts
#yay -S ttf-mac-fonts
cp tint2rc /etc/xdg/tint2/
cp menu.xml /etc/xdg/openbox/
cp rc.xml /etc/xdg/openbox/
echo "tint2 &" >> /etc/xdg/openbox/autostart
echo "nm-applet &" >> /etc/xdg/openbox/autostart
CMD='exec openbox-session'
su saveguest -c "echo \"$CMD\" > ~/.xinitrc"
CMD='if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then exec startx; fi'
su saveguest -c "echo \"$CMD\" >> ~/.bash_profile"
