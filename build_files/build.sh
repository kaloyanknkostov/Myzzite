#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

dnf5 copr enable -y imput/helium 
dnf5 -y copr enable scottames/ghostty
dnf5 -y copr enable atim/starship 
dnf5 -y copr enable lihaohong/yazi
dnf5 -y copr enable lionheartp/Hyprland  
dnf5 -y copr enable theblackdon/kineticwe  
dnf5 -y copr enable codifryed/CoolerControl
#____packages
dnf5 install -y tmux neovim ripgrep helium-bin
dnf5 install -y atuin bat coolercontrol docker eza fzf ghostty gradle maven postgresql postgresql-server starship stow yazi zoxide zsh 
dnf5 install dnf-plugins-core
#____
dnf5 swap -y kwin kineticwe  
dnf5 remove -y kwin-common kwin-libs kglobalacceld kdecoration
dnf5 install -y noctalia-git
#____
#repos disabled
dnf5 -y copr disable imput/helium 
dnf5 -y copr disable codelingo/coolercontrol 
dnf5 -y copr disable pgdev/ghostty
dnf5 -y copr disable atim/starship 
dnf5 -y copr disable varlad/yazi
dnf5 -y copr disable lionheartp/Hyprland  
dnf5 -y copr disable theblackdon/kineticwe  

dnf5 clean all
systemctl enable podman.socket
systemctl enable coolercontrold
#cursor
curl https://cursor.com/install -fsS | bash
# opencode
curl -fsSL https://opencode.ai/install | bash
# sdkman 
curl -s "https://get.sdkman.io" | bash

