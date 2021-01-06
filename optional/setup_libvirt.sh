
# Base installation of qemu and libvirt
sudo pacman -S --noconfirm --needed libvirt virsh qemu

# NAT network
sudo pacman -S --noconfirm --needed ebtables dnsmasq

# Bridge
sudo pacman -S --noconfirm --needed bridge-utils

# Remote management
sudo pacman -S --noconfirm --needed openbsd-netcat

# Enable services and update groups for user.
sudo gpasswd -a $USER libvirt
sudo systemctl enable libvirtd --now
