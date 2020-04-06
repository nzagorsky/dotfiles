
# Remove desktop env completely:

    pacman -Rnsc $ENVNAME


# List packages of a group and remove them one by one:

    sudo pacman -Sp plasma kde-applications plasma-meta plasma-wayland-session --print-format '%n'  > to_delete.txt
    while read in ; do sudo pacman -Runsc --noconfirm $in ; done < to_delete.txt
