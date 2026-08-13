#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

dnf5 -y copr enable imput/helium 
dnf5 -y copr enable scottames/ghostty
dnf5 -y copr enable atim/starship 
dnf5 -y copr enable lihaohong/yazi
dnf5 -y copr enable lionheartp/Hyprland  
dnf5 -y copr enable theblackdon/kineticwe  
dnf5 -y copr enable codifryed/CoolerControl
#____packages
dnf5 install -y neovim ripgrep helium-bin curl
dnf5 install -y atuin bat docker eza ghostty postgresql postgresql-server starship stow yazi zoxide zsh curl wget tar unzip zip
dnf5 install -y dnf-plugins-core coolercontrol coolercontrold
#____
dnf5 swap -y kwin kineticwe  
dnf5 remove -y kwin-common kwin-libs kglobalacceld kdecoration
dnf5 install -y noctalia-git
#____
#repos disabled
dnf5 -y copr disable imput/helium 
dnf5 -y copr disable scottames/ghostty
dnf5 -y copr disable atim/starship 
dnf5 -y copr disable lihaohong/yazi
dnf5 -y copr disable lionheartp/Hyprland  
dnf5 -y copr disable theblackdon/kineticwe
dnf5 -y copr disable codifryed/CoolerControl
dnf5 clean all
systemctl enable podman.socket
systemctl enable coolercontrold.service

