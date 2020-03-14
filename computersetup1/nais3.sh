useradd -mG wheel,users,audio,lp,optical,storage,video,power,uucp -s /bin/bash saveguest
printf "Welcome1mooredna\nWelcome1mooredna\n" | passwd saveguest
pacman -S xorg xorg-xinit xorg-twm xterm --noconfirm
pacman -S xfce4 xfce4-goodies --noconfirm
pacman -R xfce4-power-manager
pacman -R xfce4-screensaver
pacman -S tk wget vim vi htop nload ncdu tmux iotop
pacman -S network-manager-applet guvcview openbox nitrogen tigervnc
pacman -S qt5-base hdf5 python-h5py ipython opencv
pacman -S python-pandas python-pytables python-matplotlib 
pacman -S python-seaborn python-scikit-learn jupyter-notebook
pacman -S python-pyserial arduino-docs arduino-avr-core
wget http://archive.virtapi.org/packages/a/arduino/arduino-1%3A1.8.9-1-x86_64.pkg.tar.xz
pacman -U arduino-1:1.8.9-1-x86_64.pkg.tar.xz
systemctl enable sshd
systemctl start sshd
timedatectl set-ntp 1
EDITOR=nano visudo
