
 Check debug

    gsettings --schemadir \
    ~/.local/share/gnome-shell/extensions/gsconnect@andyholmes.github.io/schemas/ \
    get org.gnome.Shell.Extensions.GSConnect debug


Set debug to `false`

    gsettings --schemadir \
    ~/.local/share/gnome-shell/extensions/gsconnect@andyholmes.github.io/schemas/ \
    set org.gnome.Shell.Extensions.GSConnect debug false


In case `Mount` option doesn't work restart KDE connect app on Android. Details:
- https://github.com/GSConnect/gnome-shell-extension-gsconnect/issues/544
