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
sudo pacman -S xorg xorg-xinit openbox ttf-dejavu ttf-liberation tint2 network-manager-applet --noconfirm
sudo pacman -S tk pcmanfm gpicview mupdf tigervnc chromium guvcview --noconfirm
sudo pacman -S imagemagick imagemagick-doc ghostscript libheif libraw libwmf --noconfirm
sudo cp /root/arch_install_scripts/rc.xml /etc/xdg/openbox/
sudo cp /root/arch_install_scripts/menu.xml /etc/xdg/openbox/
sudo cp /root/arch_install_scripts/autostart /etc/xdg/openbox/
sudo cp /root/arch_install_scripts/tint2rc /etc/xdg/tint2/
yay -S ttf-ms-fonts --noconfirm
yay -S ttf-mac-fonts --noconfirm
yay -S st --noconfirm
#------------------------------------------------------------- some data science
sudo pacman -S qt5-base hdf5 python-h5py ipython opencv --noconfirm
sudo pacman -S python-pandas python-pytables python-matplotlib --noconfirm
sudo pacman -S python-pyserial arduino-docs arduino-avr-core arduino anduino-cli --noconfirm
#------------------------------------------------------------- problem stuff at end
yay -S icdiff --noconfirm