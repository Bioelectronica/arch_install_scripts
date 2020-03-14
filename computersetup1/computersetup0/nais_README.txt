scp saveguest@128.92.140.45:/etc/hosts /etc/hosts
scp saveguest@rgb-wan:~/nais/nais1.sh .
sh nais1.sh
df -h

should result in:

Filesystem      Size  Used Avail Use% Mounted on
dev              32G     0   32G   0% /dev
run              32G   94M   32G   1% /run
/dev/sda1       635M  635M     0 100% /run/archiso/bootmnt
cowspace        256M  6.9M  250M   3% /run/archiso/cowspace
/dev/loop0      521M  521M     0 100% /run/archiso/sfs/airootfs
airootfs        256M  6.9M  250M   3% /
tmpfs            32G     0   32G   0% /dev/shm
tmpfs            32G     0   32G   0% /sys/fs/cgroup
tmpfs            32G     0   32G   0% /tmp
tmpfs            32G  1.9M   32G   1% /etc/pacman.d/gnupg
tmpfs           6.3G     0  6.3G   0% /run/user/0
/dev/nvme0n1p2  1.8T  2.0G  1.7T   1% /mnt
/dev/nvme0n1p1  511M   45M  467M   9% /mnt/boot


arch-chroot /mnt

Now in the CHROOT make sure to go into the /root directory and then get the next install script

cd
scp saveguest@rgb-wan:~/nais/nais2.sh .
sh nais2.sh
EDITOR=nano visudo

uncomment the second line below in the editor that the above EDITOR=... did 
## Uncomment to allow members of group wheel to execute any command
# %wheel ALL=(ALL) ALL
save the change by control-x then yes then <return>

exit
shutdown now

Turn the NUC off and take out the Arch Linux boot USB stick.
Turn the computer on again and login with the usual password as root.

scp saveguest@rgb-wan:~/nais/nais3.sh .
sh nais3.sh
exit


Login as saveguest with the usual password.

scp saveguest@rgb-wan:~/nais/nais4.sh .
sh nais4.sh
startx

Open a Terminal window.

sudo systemctl edit getty@tty1

An editor window will open up and paste in the following:

[Service]
ExecStart=
ExecStart=-/usr/bin/agetty --autologin saveguest --noclear %I $TERM


Make sure you are not root user, ie prompt should indicate saveguest as the user then:

nano ~/.bash_profile

add the following lines to the end of the bash_profile:

if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi


We have to make sure the "arduino" package is not updated so change to:

sudo nano /etc/pacman.conf

# Pacman won't upgrade packages listed in IgnorePkg and members of IgnoreGroup
IgnorePkg   = arduino
#IgnoreGroup =


To get the vnc config files to show up you have to run vncserver:

vncserver
vncserver -kill :1

[saveguest@he6 .vnc]$ cd ~/.vnc
[saveguest@he6 .vnc]$ cat config 
## Supported server options to pass to vncserver upon invocation can be listed
## in this file. See the following manpages for more: vncserver(1) Xvnc(1).
## Several common ones are shown below. Uncomment and modify to your liking.
##
securitytypes=vncauth,tlsvnc
# desktop=sandbox
geometry=1200x900
# localhost
# alwaysshared
[saveguest@he6 .vnc]$ cat xstartup
exec openbox-session
[saveguest@he6 .vnc]$ 


To get the vnc started at system boot we need to make a systemd service file:

[saveguest@he6 ~]$ su
Password: 
[root@he6 saveguest]# cd /etc/systemd/system
[root@he6 system]# touch vncserver@:1.service
[root@he6 system]# nano vncserver@:1.service
[root@he6 system]# cat vncserver\@\:1.service 
[Unit]
Description=Remote desktop service (VNC)
After=syslog.target network.target

[Service]
Type=simple
User=saveguest
PAMName=login
PIDFile=/home/%u/.vnc/%H%i.pid
ExecStartPre=/bin/sh -c '/usr/bin/vncserver -kill %i > /dev/null 2>&1 || :'
ExecStart=/usr/bin/vncserver %i -geometry 1440x900 -alwaysshared -fg
ExecStop=/usr/bin/vncserver -kill %i

[Install]
WantedBy=multi-user.target

[root@he6 system]# systemctl daemon-reload
[root@he6 system]# systemctl enable vncserver@:1.service
Created symlink /etc/systemd/system/multi-user.target.wants/vncserver@:1.service → /etc/systemd/system/vncserver@:1.service.
[root@he6 system]# 


