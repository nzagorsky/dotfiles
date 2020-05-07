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

# Gnome's GDM taking over A2DP

    sudo setfacl -m u:gdm:r /usr/bin/pulseaudio
    sudo pkill pulseaudio

> source: https://unix.stackexchange.com/questions/254462/cannot-get-a2dp-mode-work-with-my-bluetooth-headphones-on-gnome

