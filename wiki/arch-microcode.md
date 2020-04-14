

# Install microcode

    sudo pacman -S intel-ucode

# Then update grub config:

    grub-mkconfig -o /boot/grub/grub.cfg
