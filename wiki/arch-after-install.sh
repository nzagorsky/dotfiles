sudo systemctl enable NetworkManager --now
sudo systemctl enable bluetooth --now
sudo pacman -S --needed --noconfirm pulseaudio-bluetooth
