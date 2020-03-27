# Enable Multilib
Uncomment in /etc/pacman.conf:

    [multilib]
    Include = /etc/pacman.d/mirrorlist

    sudo pacman -Syyuu


# Install AMD

    sudo pacman -S lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader


source: https://github.com/lutris/lutris/wiki/Installing-drivers


# Install Wine and Lutris:

    sudo pacman -S wine lutris
