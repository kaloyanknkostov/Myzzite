#!/bin/bash

set -ouex pipefail

# Keep downloaded RPMs in the cache mount so rebuilds skip re-downloading.
# Bazzite does the same; without this, dnf5 deletes packages after each transaction.
dnf5 config-manager setopt keepcache=1

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
dnf5 install -y \
    neovim ripgrep helium-bin atuin bat docker eza ghostty \
    postgresql postgresql-server starship stow yazi zoxide \
    zsh zsh-autosuggestions zsh-syntax-highlighting wget tar unzip zip \
    dnf-plugins-core coolercontrol coolercontrold
dnf5 install -y https://github.com/mroboff/vm-curator/releases/download/v1.4.0/vm-curator-1.4.0-1.x86_64.rpm
#____
dnf5 swap -y kwin kineticwe  
dnf5 remove -y kwin-common kwin-libs kglobalacceld kdecoration
dnf5 install -y noctalia-git
#____remove bazzite apps
dnf5 remove -y filelight plasma-systemmonitor kinfocenter bazzite-portal krdc krdc-libs krfb krfb-libs webapp-manager lutris \
    waydroid waydroid-selinux kate kwrite kate-plugins kate-libs \
    kate-krunner-plugin konsole konsole-part rom-properties rom-properties-kf6 rom-properties-utils rom-properties-common
# Hide leftover launchers that are overlay files, or packages we must keep.
rm -f \
    /usr/share/applications/bbrew.desktop \
    /usr/share/applications/bazzite-documentation.desktop \
    /usr/share/applications/system-update.desktop \
    /usr/share/applications/org.kde.kmenuedit.desktop \
    /usr/share/applications/waydroid-container-restart.desktop \
    /usr/share/applications/waydroid.app.install.desktop \
    /usr/share/applications/waydroid.market.desktop \
    /usr/share/applications/Waydroid.desktop
#____
#repos disabled
dnf5 -y copr disable imput/helium 
dnf5 -y copr disable scottames/ghostty
dnf5 -y copr disable atim/starship 
dnf5 -y copr disable lihaohong/yazi
dnf5 -y copr disable lionheartp/Hyprland  
dnf5 -y copr disable theblackdon/kineticwe
dnf5 -y copr disable codifryed/CoolerControl

# Do not run `dnf5 clean all` — it wipes /var/cache/libdnf5 and defeats the cache mount.
# Reset keepcache so the installed OS does not retain RPMs under /var.
dnf5 config-manager setopt keepcache=0

systemctl enable podman.socket
systemctl enable coolercontrold.service

