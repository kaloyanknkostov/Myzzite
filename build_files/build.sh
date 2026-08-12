#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

# --- Enable COPR Repositories ---
dnf5 -y copr enable imput/helium 
dnf5 -y copr enable scottames/ghostty
dnf5 -y copr enable atim/starship 
dnf5 -y copr enable lihaohong/yazi
dnf5 -y copr enable lionheartp/Hyprland  
dnf5 -y copr enable theblackdon/kineticwe  
dnf5 -y copr enable codifryed/CoolerControl

# --- Install Packages ---
# Note: dnf-plugins-core merged here to streamline layer operations
dnf5 install -y \
  tmux neovim ripgrep helium-bin dnf-plugins-core \
  atuin bat coolercontrol docker eza ghostty postgresql \
  postgresql-server starship stow yazi zoxide zsh

# --- Desktop Component Swap & Clean ---
# Using --skip-unavailable prevents non-zero exits if packages are missing
dnf5 swap -y --skip-unavailable kwin kineticwe  
dnf5 remove -y --skip-unavailable kwin-common kwin-libs kglobalacceld kdecoration
dnf5 install -y noctalia-git

# --- Disable COPR Repositories ---
# Mismatches (e.g. pgdev/ghostty vs scottames/ghostty) corrected to match enable section
dnf5 -y copr disable imput/helium 
dnf5 -y copr disable scottames/ghostty
dnf5 -y copr disable atim/starship 
dnf5 -y copr disable lihaohong/yazi
dnf5 -y copr disable lionheartp/Hyprland  
dnf5 -y copr disable theblackdon/kineticwe  
dnf5 -y copr disable codifryed/CoolerControl

# --- Cleanup & Services ---
dnf5 clean all
systemctl enable podman.socket
systemctl enable coolercontrold

# --- External Tool Installers ---
# Cursor
curl https://cursor.com/install -fsS | bash
# OpenCode
curl -fsSL https://opencode.ai/install | bash
# SDKMAN!
curl -s "https://get.sdkman.io" | bash
