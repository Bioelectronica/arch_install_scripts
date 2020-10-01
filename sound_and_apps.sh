#!/bin/sh
# run this as user saveguest with ./root/arch_install_scripts/sound_and_apps.sh
yay -S pulseaudio pulseaudio-alsa pulseaudio-bluetooth pulseaudio-equalizer pulseaudio-jack pulseaudio-zeroconf alsa-utils pavucontrol --noconfirm
systemctl --user enable pulseaudio
systemctl --user enable pulseaudio.socket
yay -S gnome-disk-utility --noconfirm
yay -S google-chrome --noconfirm
yay -S zoom --noconfirm
yay -S audacity pinta shotwell libreoffice-still --noconfirm
cp /root/arch_install_scripts/dotconfig_tint2_tint2rc ~/.config/tint2/tint2rc
sudo cp /root/arch_install_scripts/org.gnome.DiskUtility.desktop /usr/share/applications/ 
