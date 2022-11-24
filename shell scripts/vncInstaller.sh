# make sure ssh, xfce and dbus-x11 are installed.
sudo apt update && sudo apt upgrade -y
sudo install xfce4 xfce4-goodies dbus-x11 ssh -y
sudo apt install tigervnc-standalone-server -y
vncpasswd
echo -e "#!/bin/sh\nunset SESSION_MANAGER\nunset DBUS_SESSION_BUS_ADDRESS\nexec /bin/sh /etc/xdg/xfce4/xinitrc" > ~/.vnc/xstartup
sudo chmod 755 ~/.vnc/xstartup
