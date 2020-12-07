
Lenovo IdeaPad 15 touchpad usually is not working. In order to fix create cron/systemd with the following:

    modprobe i2c_hid
    echo "i2c-ELAN0001:00" > /sys/bus/i2c/drivers/elants_i2c/unbind
    echo "i2c-ELAN0001:00" > /sys/bus/i2c/drivers/i2c_hid/bind

When elants_i2c is not included in kernel it's enough to:

    sudo bash -c "echo 'blacklist elants_i2c' > /etc/modprobe.d/touchpad-fix.conf"

