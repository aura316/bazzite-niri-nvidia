#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

dnf5 install -y cascadia-code-fonts 
dnf5 install -y tmux fzf fd-find bat eza cliphist wtype
dnf5 install -y zsh zsh-autosuggestions zsh-syntax-highlighting

# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging
dnf5 -y copr enable scottames/ghostty
dnf5 -y install ghostty
dnf5 -y copr disable scottames/ghostty

dnf5 -y copr enable yalter/niri
dnf5 -y install niri
dnf5 -y copr disable yalter/niri

dnf5 -y copr enable abn/throttled
dnf5 -y remove thermald
dnf5 -y install throttled
dnf5 -y copr disable abn/throttled

# Fetch noctalia from terra
dnf5 config-manager setopt terra.enabled=1 terra-extras.enabled=1
dnf5 -y install noctalia-shell
dnf5 config-manager setopt terra.enabled=0 terra-extras.enabled=0


#### System Unit Files
systemctl enable throttled
