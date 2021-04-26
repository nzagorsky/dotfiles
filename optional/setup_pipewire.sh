# Script to install pipewire instead of pulseaudio
# source: https://askubuntu.com/questions/1333404/how-to-replace-pulseaudio-with-pipewire-on-ubuntu-21-04
# another source: https://www.guyrutenberg.com/2021/03/11/replacing-pulseaudio-with-pipewire/

print_current_audioserver() {
    echo "Audioserver now: $(pactl info | grep '^Server Name')"
}

print_current_audioserver

sudo apt-get install -y pipewire-audio-client-libraries libspa-0.2-bluetooth
sudo touch /etc/pipewire/media-session.d/with-pulseaudio
sudo cp /usr/share/doc/pipewire/examples/systemd/user/pipewire-pulse.* /etc/systemd/user/

# Check for new service files with:
systemctl --user daemon-reload

# Disable and stop the PulseAudio service with:
systemctl --user --now disable pulseaudio.service pulseaudio.socket

# Enable and start the new pipewire-pulse service with:
systemctl --user --now enable pipewire pipewire-pulse
systemctl --user mask pulseaudio
systemctl --user restart pipewire pipewire-pulse
