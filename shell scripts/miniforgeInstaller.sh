packageLink="https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh"
sudo wget ${packageLink}
packageName=$(find -name "Miniforge3*.sh")
bash ${packageName}
sudo rm packageName
