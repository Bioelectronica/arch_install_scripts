#!/bin/sh
#------------------------------------------------------------- yay
cd
mkdir git-repos
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
sudo pacman -S tk pcmanfm gpicview mupdf chromium guvcview light arandr --noconfirm
sudo pacman -S imagemagick imagemagick-doc ghostscript libheif libraw libwmf --noconfirm
sudo cp /root/arch_install_scripts/rc.xml /etc/xdg/openbox/
sudo cp /root/arch_install_scripts/menu.xml /etc/xdg/openbox/
sudo cp /root/arch_install_scripts/autostart /etc/xdg/openbox/
sudo cp /root/arch_install_scripts/tint2rc /etc/xdg/tint2/
yay -S ttf-ms-fonts --noconfirm
yay -S ttf-mac-fonts --noconfirm
yay -S st --noconfirm
sudo pacman -S xfce4-terminal --noconfirm
#------------------------------------------------------------- data science
sudo pacman -S qt5-base hdf5 python-h5py ipython opencv --noconfirm
sudo pacman -S python-pandas python-pytables python-matplotlib --noconfirm
sudo pacman -S python-seaborn python-scikit-learn jupyter-notebook --noconfirm
sudo pacman -S python-pyserial arduino-docs arduino-avr-core arduino --noconfirm
sudo pacman -S python-pip python-google-api-python-client python-oauth2client ffmpeg --noconfirm
yay -S python-bokeh --noconfirm
yay -S python-pytest python-psutil --noconfirm
yay -S arduino-cli --noconfirm
#------------------------------------------------------------- configure
arduino-cli core update-index
arduino-cli core install arduino:avr
#------------------------------------------------------------- problem stuff at end
yay -S icdiff --noconfirm
