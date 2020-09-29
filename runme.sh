#!/bin/sh
#------------------------------------------------------------- yay
cd
cd git-repos
git clone https://aur.archlinux.org/yay-bin
cd yay-bin
makepkg -si --noconfirm
cd
yay -S create_ap-git --noconfirm
yay -S rc-local --noconfirm
#------------------------------------------------------------- GUI
echo "exec openbox-session" > ~/.xinitrc
cat /root/arch_install_scripts/bash_profile_addendum.sh >> ~/.bash_profile
sudo pacman -S xorg-server xorg-xinit xterm openbox ttf-dejavu ttf-liberation tint2 network-manager-applet --noconfirm
sudo pacman -S tk pcmanfm gpicview mupdf tigervnc chromium guvcview light arandr --noconfirm
sudo pacman -S imagemagick imagemagick-doc ghostscript libheif libraw libwmf --noconfirm
sudo cp /root/arch_install_scripts/rc.xml /etc/xdg/openbox/
sudo cp /root/arch_install_scripts/menu.xml /etc/xdg/openbox/
sudo cp /root/arch_install_scripts/autostart /etc/xdg/openbox/
sudo cp /root/arch_install_scripts/tint2rc /etc/xdg/tint2/
yay -S ttf-ms-fonts --noconfirm
yay -S ttf-mac-fonts --noconfirm
yay -S st --noconfirm
#------------------------------------------------------------- data science
sudo pacman -S qt5-base hdf5 python-h5py ipython opencv --noconfirm
sudo pacman -S python-pandas python-pytables python-matplotlib --noconfirm
sudo pacman -S python-seaborn python-scikit-learn jupyter-notebook --noconfirm
sudo pacman -S python-pyserial arduino-docs arduino-avr-core arduino --noconfirm
sudo pacman -S python-pip python-google-api-python-client python-oauth2client ffmpeg --noconfirm
yay -S python-bokeh --noconfirm
yay -S python-pytest python-psutil
yay -S arduino-cli
#------------------------------------------------------------- configure
arduino-cli core update-index
arduino-cli core install arduino:avr
sudo echo ":0=saveguest" >> /etc/tigervnc/vncserver.users
sudo rm /usr/share/xsessions/openbox-kde.desktop
#------------------------------------------------------------- problem stuff at end
yay -S icdiff --noconfirm
