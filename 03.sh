pacman -S xorg-server xorg-apps xorg-xinit openbox tint2 pavucontrol pulseaudio xfce4-terminal --noconfirm
pacman -S tk wget vim vi htop nload ncdu tmux iotop tigervnc network-manager-applet guvcview --noconfirm
pacman -S epiphany pcmanfm ristretto viewnior mupdf gedit light arandr arch-install-scripts dosfstools parted --noconfirm
chmod u+s /usr/bin/light
pacman -S qt5-base hdf5 python-h5py ipython opencv --noconfirm
pacman -S python-pandas python-pytables python-matplotlib --noconfirm
pacman -S python-seaborn python-scikit-learn jupyter-notebook --noconfirm
pacman -S python-pyserial arduino-docs arduino-avr-core --noconfirm
pacman -U arduino-1:1.8.9-1-x86_64.pkg.tar.xz --noconfirm
pacman -S ttf-ubuntu-font-family ttf-croscore ttf-liberation noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-dejavu --noconfirm
cp hosts /etc/hosts
cp tint2rc /etc/xdg/tint2/
cp menu.xml /etc/xdg/openbox/
cp rc.xml /etc/xdg/openbox/
echo "tint2 &" >> /etc/xdg/openbox/autostart
echo "nm-applet &" >> /etc/xdg/openbox/autostart
CMD="exec openbox-session"
su saveguest -c "echo \"$CMD\" > ~/.xinitrc"
cat bash_profile_addendum.sh >> /home/saveguest/.bash_profile
su saveguest -c "mkdir ~/git-repos"
su saveguest -c "cd ~/git-repos;git clone https://aur.archlinux.org/yay-bin"
su saveguest -c "cd ~/git-repos/yay-bin;makepkg -si --noconfirm"
su saveguest -c "yay -S google-chrome --noconfirm"
su saveguest -c "yay -S zoom --noconfirm"
su saveguest -c "yay -S icdiff --noconfirm"
su saveguest -c "yay -S create_ap-git --noconfirm"
su saveguest -c "yay -S rstudio-desktop-bin --noconfirm"
su saveguest -c "yay -S etcher-bin --noconfirm"
su saveguest -c "yay -S ttf-ms-fonts --noconfirm"
su saveguest -c "yay -S ttf-mac-fonts --noconfirm"
su saveguest -c "yay -S ttf-google-fonts-git"
timedatectl set-ntp 1
