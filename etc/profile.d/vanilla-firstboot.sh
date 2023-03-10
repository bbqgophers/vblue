if test "$(id -u)" -gt "0" && test -d "$HOME"; then
    if test ! -e "$HOME"/.config/vanilla/firstboot-done; then
        mkdir -p "$HOME"/.config/autostart
        cp -f /etc/skel.d/.config/autostart/vanilla-firstboot.desktop "$HOME"/.config/autostart
    fi
fi

if test "$(id -u)" -gt "0" && test -d "$HOME"; then
    if test ! -e "$HOME"/.config/nix/nix.conf; then
        mkdir -p "$HOME"/.config/nix
        cp -f /etc/skel.d/.config/nix/nix.conf "$HOME"/.config/nix
    fi
fi

if test "$(id -u)" -gt "0" && test -d "$HOME"; then
    if test ! -e "$HOME"/.config/environment.d/00-nix-unfree.conf; then
        mkdir -p "$HOME"/.config/environment.d
        cp -f /etc/skel.d/.config/environment.d/00-nix-unfree.conf "$HOME"/.config/environment.d
    fi
fi
if test "$(id -u)" -gt "0" && test -d "$HOME"; then
    if test ! -e "$HOME"/.config/environment.d/01-nix-insecure.conf; then
        mkdir -p "$HOME"/.config/environment.d
        cp -f /etc/skel.d/.config/environment.d/01-nix-insecure.conf "$HOME"/.config/environment.d
    fi
fi