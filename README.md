# Ubuntu installation tutorial
## 1. Install Ubuntu
- Step 1: Download Ubuntu .ios file and make a flash driver with it.
- Step 2: Install by flash driver. Remeber: minimal installation --> install third-party software for wifi and desktop (doubted) --> username: saveguest; computer name: slave / master; passwd: Welco....

## 2. Run bash scripts
- Step 1: Download bash scripts from the server. (location: /home/liy/'shell\ scripts')
- Step 2: Run expressvpnInstaller.sh --> open expressvpn --> installPackage.sh --> miniforgeInstaller.sh --> recreateEnvironment.sh.

## 3. Configure nucs
- Step 1: Clone repos on specific branch and commit head from github. (repos: arduino, analytics, OpticalPodAnalyzer, ics, icserver and ashwini-playground) (Any changes should confirm with related persons)
- Step 2: Modify .git/config file. Add token in the github link. (https://**token**@github....)
- Step 3: Create sm.config first, and add content to this file basing on sm.config_example. Get into ics repos and execute 'setup.sh' and 'setup2.sh'.
- Step 4: Install arduino-cli using **sudo snap install arduino arduino-cli**. (If you cannot use arduino, try Valerio Bozzolan's answer in this link https://bugs.launchpad.net/ubuntu/+source/arduino/+bug/1916278)
- Step 5: Set static ip address. (https://unix.stackexchange.com/questions/290938/assigning-static-ip-address-using-nmcli)
_ Step 6: Add content to /etc/hosts. (Add ip address and device name to the file.)

# DeBian installation tutorial
## 0. Above all
Tip 1: When you don’t know or forget how to use a certain command, use ‘-h’ or ‘--help’ to see the instruction.

Tip 2: If some connection/http errors happened, check the vpn status first (**use expressvpn status**).

## 1. Install DeBian
- Step 1. Download DeBian iso. (https://www.debian.org/)

- Step 2. Download balenaEtcher to make a USB driver to be boot driver. (https://www.balena.io/etcher/)

- Step 3. Plug USB driver in NUC and start to install.

- Step 4. Some things important: 
    - Username: saveguest; password: Welcome one; host name: master/slave. 
    - If network setting failed, check the Ethernet connection first. 
    - Partition disks: **Guided – use entire disk** ----> **All files in one partition** ----> **Finish partitioning and write changes to disk** ----> **Yes**.
    - Use xfce desktop environment.

- Step 5. Unplug USB driver after install finishing.

- Step 6. Config sudoers file: **enter admin account** ----> **vim /etc/sudoers** ----> **add username ALL(ALL:ALL) ALL under root line**.

- Step 7. Install expressvpn. **expressvpn activate** is to activate account; **expressvpn connect** is to connect remote vpn server; **expressvpn disconnect** is to disconnect vpn server.

## 2. Update kernel
#### \# below is summary of the first answer in https://unix.stackexchange.com/questions/444358/what-is-the-proper-way-of-installing-new-kernel-manually-on-debian-9.
- Step 1. Change content in sources file. Use **vim /etc/apt/sources.list** to edit file ----> replace content with lines in **sources.list** file in the same folder.

- Step 2. Change content in **/etc/apt/preferences**. Use vim **/etc/apt/preferences** to edit file ----> replace content with lines in **preferences.txt** file in same folder.

- Step 3. Step 3: run **apt-get update** ----> run **apt-cache search linux-image** to find the kernel you want to install ----> run **apt-get install linux-image-flavour** to install specific kernel (change **linux-image-flavour** to the name of desired kernel).

- Step 4. **reboot** and check the kernel version (use **uname -r**).

## 3. VNC
### 3.1 Server
#### \# Below is summary of https://atetux.com/how-to-install-tigervnc-on-debian-11, more information can be seen in the link above.

- Step 1. Make sure Debian install xfce4, dbus-x11 and tigervnc. If they are not installed, 
    - use **sudo apt update && sudo apt upgrade -y** to update apt list; 
    - use **sudo apt install xfce4 xfce4-goodies dbus-x11 -y** install modules. 
    - use **sudo apt install tigervnc-standalone-server -y** install tigervnc.

- Step 2. VNC configuration. Use **vncpasswd** to set a password for vnc.

- Step 3. Create xstartup file if it doesn’t exist. Use **vim ～/.vnc/xstartup** to edit (or create) xstartup file. Add content in **xstartup.txt** file in the same folder.

- Step 4. use **sudo vncserver -localhost no (_don’t forget the sudo_)** to run the vnc server.

- Step 5. use **sudo vncserver -list (_don’t forget the sudo_)** to see information of vnc server.

### 3.2 Client
- Step 1. Install vncviewer. Use **sudo apt install tigervnc-viewer -y**.

- Step 2. Input the ip address (check by **ip addr** on sever terminal) and port (check by **sudo vncserver -list** on server terminal) and input the password.

- Step 3. Clik connect.

### 3.3 others
- https://embswit.wordpress.com/2013/02/08/permissions-on-the-vnc-server-xstartup-file/ This link is something about change the permission of accessing xstartup file, but we can use sudo to solve the error, too. It is up to you.
- xtigervncviewer instead of vncviewer
- tigervncserver instead of vncserver
- Don't download realvnc it sucks
- Don’t us gnome because it will cause to black screen.
- Remember turn on the ssh server.

## 4. Wifi
#### \# https://unix.stackexchange.com/questions/556946/possible-missing-firmware-lib-firmware-i915-for-module-i915/556947#556947
- Step 1. Install and update the apt-file: **sudo apt update** ----> **sudo apt install apt-file** ----> **sudo apt-file update**.

- Step 2. Install firmware list. Use **sudo apt install firmware**.

- Step 3.  If above not works, install wifi firmware. Use **sudo apt search firmware-iwlwifi** ----> **sudo apt install firmware-iwlwifi** ----> **reboot**. (https://www.cyberciti.biz/faq/intel-wifi-on-debian-linux-when-you-get-firmware-failed-to-load-iwlwifi-8265-36-error/ Basically, you don’t have to do all the steps in the link, just doing the above steps should work.)

- Note: If you can not login the desktop, see 5.B.

## 5. Python environment and transport environment
### 5.1 Install the miniforge
- Step 1. Download miniforge package from https://github.com/conda-forge/miniforge.

- Step 2. Install miniforge: use **bash package-name**.

- Step 3. Always choose “yes” or just click Enter, it is up to you. Use **conda config --set auto_activate_base false** to deactivate the environment.

- Note: 
  - #python packages
  - using following website:
  - https://github.com/Bioelectronica/arch_install_scripts/blob/master/runme.sh 
  - did not install jupyter-notebook
  - add python-systemd

### 5.2 Transport environment with .yml
#### \# More details see https://www.anaconda.com/blog/moving-conda-environments.
- Step 1. Create an environment. Use **conda create -n env_name**.

- Step 2. Export environment file (.yml). Use **conda env export environment.yml** (environment.yml is a default name).

- Step 3. Recreate an environment with .yml. Use **conda env create -f environment.yml -n yours_env_name**.

- Note: Remember open the vpn when installing libraries.

## 6. Install package
Just keep using **sudo apt install package_name** basing on **package_list.txt** in the same folder.

## 7. Change font (or language)
#### \# https://blog.csdn.net/Yang838020787/article/details/118141643
- Step 1. Install font configuration software. Use **sudo apt install ttf-mscorefonts-installer** and **sudo pat install fontconfig**.

- Step 2. Download font file (.ttf). Create new folder **myfont** under **/usr/share/fonts/truetype/** and copy **\*.tff** file to this folder, then change the authority by **chmod 777 \*.ttf**.

- Step 3. Create font cache. Use **mkfontscale** ----> **mkfontdir** ----> **fc-cache -fv** ----> **fc-list**.

- Step 4. Add Chinese supports. Use **sudo apt install locales** ----> **sudo dpkg-reconfigure locales**.

- Step 5. Select the encodings you want and set one as the default, for example, if I want to change English into Chinese, I will set zh_CN GB2312 as the default.

- (For Chinese) Step 6. Install Chinese words library. Use **sudo apt install ttf-wqy-zenhei**.

- Step 7. reboot.

- Note: If you want to change back or change to other language, do **sudo dpkg-reconfigure locales** and change default language.

## 8. Suspend issue
Possible way 1: go to the **boot menu** ----> **Power** ----> **secondary power setting** ----> unchoose **PCIe ASPM Support**. (Remeber save configuration before esc.)

## 9. Shell run
- Step 1: run **expressvpnInstaller.sh** by using **bash expressvpnInstall.sh**. (Make sure expressvpn package is in the same folder as the script) Activate and connect to the vpn server by using **expressvpn activate** (once) and **expressvpn connect**.
- Step 2: run **updateKernel.sh** by using **sudo bash updateKernel.sh**.
- Step 3: run **wifi.sh** by using **bash wifi.sh**. (Make sure vpn is open)
- Step 4: run **installPackages.sh** by using **bash installPackage.sh**.
- Step 5: run **vncInstaller.sh** by using **bash vncInstaller.sh**. (Make sure the password is that Welcome***** one and view-only password is wifi password)
- Step 6: run **miniforgeInstaller.sh** by using **bash miniforgeInstaller.sh**. (Make usre you are in the conda environment. After installing, you can open another terminal to get into virtual environment.)
- Step 6.1: (**Only when you need**) Export environment ----> run **environmentExport.sh** by using **bash environmentExport.sh**. (This script needs to run in the target environment.)
- Step 6.2: (Using .yml rebuild environment.) Recreate environment ----> run **recreateEnvironment.sh** by using **bash recreateEnvironment.sh**. (Make sure the environment.yml is exist in the current folder
- Step 7: Solve the suspend issue basing on **Sec. 8**.

## 10. Appendix
1) How to update the source list? https://wiki.debian.org/SourcesList 
2) If you cannot login the desktop. Try 
    - Deleting /home/user/.ICEauthority and /home/user/.Xauthority; if that not works, 
    - try 2) install libexo. (https://www.linuxquestions.org/questions/slackware-14/can%27t-log-in-to-xfce4-4175561079/)


