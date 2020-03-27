# Network

    sudo systemctl enable NetworkManager --now

# Bluetooth audio

    sudo pacman -S --needed --noconfirm pulseaudio-bluetooth
    sudo systemctl enable bluetooth --now

    # To use time based scheduling instead of interrupt scheduling
    # Edit /etc/pulse/default.pa
    # And add:
    load-module module-udev-detect tsched=0

    pulseaudio -k
    pulseaudio --start

> Source: https://wiki.archlinux.org/index.php/PulseAudio/Troubleshooting#Glitches.2C_skips_or_crackling
