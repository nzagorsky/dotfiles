
# Remove desktop env completely:

    pacman -Rnsc $ENVNAME


# List packages of a group and remove them one by one:

    sudo pacman -Sp plasma-meta kde-applications-meta --print-format '%n'  > to_delete.txt

    while read in ; do sudo pacman -Rs --noconfirm $in ; done < to_delete.txt


# Downgrade:

    pacman -U https://archive.archlinux.org/packages/l/linux/linux-5.7.5.arch1-1-x86_64.pkg.tar.zst


# Lock:

    nvim /etc/pacman.conf

    IgnorePkg = linux
