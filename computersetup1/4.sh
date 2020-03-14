echo "xset s off -dpms" >> ~/.xinitrc
echo "xhost +" >> ~/.xinitrc
echo "exec startxfce4" >> ~/.xinitrc
echo "export PYTHONPATH=~/git-repos/ics:~/git-repos" >> ~/.bashrc
ssh-keygen
mkdir ~/git-repos
cd ~/git-repos
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd

