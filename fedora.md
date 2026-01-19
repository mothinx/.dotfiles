# fedora.md

This document provides comprehensive information about the Fedora-specific setup for this dotfiles repository.

## System Overview

This configuration is designed for **Fedora Sericea 43** (Atomic Sway variant), which uses an immutable base system architecture.

### Package Management Approach

The system uses a three-tier package management strategy:

1. **rpm-ostree (Host System)**: Minimal layered packages for core system functionality
2. **Toolbox (Development)**: Isolated Fedora container for development tools and CLI utilities
3. **Flatpak (GUI Applications)**: Sandboxed desktop applications

This approach keeps the immutable host system minimal while providing full development capabilities in an isolated container environment.

## Installation Instructions

### Initial System Setup

```bash
# Clone dotfiles repository
git clone https://github.com/mothinx/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Layer essential packages on host
rpm-ostree install kitty kitty-terminfo tmux
rpm-ostree reboot
```

### Toolbox Setup

```bash
# After reboot, create development toolbox
toolbox create -c dev

# Enter toolbox and install packages
toolbox enter dev

# Install stow first (required for dotfiles)
dnf install stow

# Exit and install dotfiles from host
exit
cd ~/.dotfiles
make

# Re-enter toolbox and install remaining packages
toolbox enter dev

# Install all development tools
dnf install neovim git tmux fd-find btop htop clang \
    playerctl rofimoji mtr tcpdump traceroute \
    openssh-clients bash-completion rsync tree lsof inxi fpaste \
    ripgrep jq wget curl unzip

# Install programming languages with mise
curl https://mise.run | sh
echo 'eval "$(~/.local/bin/mise activate bash)"' >> ~/.bashrc
source ~/.bashrc

# Install programming language runtimes
mise use --global python@latest
mise use --global rust@latest
mise use --global node@lts

# Verify installations
mise list
```

### Flatpak Applications

```bash
# Add Flathub repository (if not already added)
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Install applications
flatpak install flathub com.google.Chrome
flatpak install flathub com.jetbrains.IntelliJ-IDEA-Ultimate
flatpak install flathub com.visualstudio.code
flatpak install flathub com.discordapp.Discord
flatpak install flathub com.obsproject.Studio
flatpak install flathub com.spotify.Client
flatpak install flathub org.videolan.VLC
flatpak install flathub com.dec05eba.gpu_screen_recorder
flatpak install flathub com.calibre_ebook.calibre
flatpak install flathub org.flameshot.Flameshot
flatpak install flathub io.missioncenter.MissionCenter
flatpak install flathub md.obsidian.Obsidian
flatpak install flathub org.gnome.Calculator
flatpak install flathub com.github.zocker_160.SyncThingy
flatpak install flathub org.kde.okular
flatpak install flathub com.valvesoftware.Steam
```

## Maintenance Commands

### Check System Status

```bash
# Check host system status
rpm-ostree status

# List layered packages
rpm-ostree status --verbose

# List all Flatpak applications
flatpak list --app

# List user-installed packages in toolbox
toolbox run -c dev dnf repoquery --userinstalled

# Check toolbox container status
toolbox list
```

### Update Systems

```bash
# Update host system (staged, requires reboot)
rpm-ostree upgrade

# Check for available updates without applying
rpm-ostree upgrade --check

# Update all Flatpak applications
flatpak update

# Update packages in toolbox
toolbox run -c dev dnf upgrade

# Or enter toolbox and update
toolbox enter dev
dnf upgrade
exit
```

### Rollback (Atomic Host Feature)

```bash
# Rollback to previous deployment
rpm-ostree rollback

# List available deployments
rpm-ostree status
```

### Cleanup

```bash
# Remove unused Flatpak runtimes
flatpak uninstall --unused

# Clean DNF cache in toolbox
toolbox run -c dev dnf clean all

# Remove old rpm-ostree deployments (keep last 2)
rpm-ostree cleanup -b
```

### Toolbox Management

```bash
# Create a new toolbox
toolbox create -c <name>

# Enter a toolbox
toolbox enter <name>

# Run command in toolbox without entering
toolbox run -c <name> <command>

# List all toolboxes
toolbox list

# Remove a toolbox
toolbox rm <name>
```

## Additional Resources

- [Fedora Silverblue Documentation](https://docs.fedoraproject.org/en-US/fedora-silverblue/) (applies to Sericea)
- [Toolbox Documentation](https://containertoolbx.org/)
- [rpm-ostree Documentation](https://coreos.github.io/rpm-ostree/)
- [Flatpak Documentation](https://docs.flatpak.org/)
- [Sway Window Manager](https://swaywm.org/)

## Notes

- This configuration is optimized for Fedora Atomic Sway (Sericea) but can be adapted for other Fedora variants
- Monitor-specific settings in Sway config (DP-1, DP-2) may need adjustment for your hardware
- The toolbox approach allows for easy experimentation without affecting the host system
- Flatpak apps are automatically updated via GNOME Software or `flatpak update`
- Container-based development provides isolation and reproducibility
