pacman -S xorg-server xorg-apps xorg-xinit openbox tint2 pavucontrol pulseaudio xfce4-terminal --noconfirm
pacman -S tk wget vim vi htop nload ncdu tmux iotop tigervnc network-manager-applet guvcview --noconfirm
pacman -S pcmanfm ristretto viewnior mupdf gedit light arandr --noconfirm
chmod u+s /usr/bin/light
pacman -S qt5-base hdf5 python-h5py ipython opencv --noconfirm
pacman -S python-pandas python-pytables python-matplotlib --noconfirm
pacman -S python-seaborn python-scikit-learn jupyter-notebook --noconfirm
pacman -S python-pyserial arduino-docs arduino-avr-core --noconfirm
wget http://archive.virtapi.org/packages/a/arduino/arduino-1%3A1.8.9-1-x86_64.pkg.tar.xz
pacman -U arduino-1:1.8.9-1-x86_64.pkg.tar.xz --noconfirm
pacman -S ttf-ubuntu-font-family ttf-croscore ttf-liberation noto-fonts noto-fonts-cjk noto-fonts-emoji --noconfirm
#yay -S ttf-ms-fonts
#yay -S ttf-mac-fonts
cp tint2rc /etc/xdg/tint2/
cp menu.xml /etc/xdg/openbox/
cp rc.xml /etc/xdg/openbox/
echo "tint2 &" >> /etc/xdg/openbox/autostart
echo "nm-applet &" >> /etc/xdg/openbox/autostart
CMD="exec openbox-session"
su saveguest -c "echo \"$CMD\" > ~/.xinitrc"
cat bash_profile_addendum.sh >> /home/saveguest/.bash_profile
su saveguest -c "mkdir ~/git-repos"
