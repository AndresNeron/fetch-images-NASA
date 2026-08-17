#!/bin/bash

# Receives absolute_path as argument
set_Background_full_path() {
    local image="$1"

    # Validate that an image path was provided
    if [[ -z "$image" ]]; then
        echo "[*] Error: No image path provided."
        return 1
    fi

	echo "$image"

	if echo "$DESKTOP_SESSION" | grep -qiE "xfce|xorg"; then
        # Query all last-image property paths directly
        for prop in $(xfconf-query -c xfce4-desktop -l | grep "last-image"); do
            echo "$prop"
            xfconf-query -c xfce4-desktop -p "$prop" -n -t string -s "$image"
        done
        xfdesktop --reload

    elif echo "$DESKTOP_SESSION" | grep -qiE "gnome|ubuntu"; then
        gsettings set org.gnome.desktop.background picture-uri "file:///$image"
        gsettings set org.gnome.desktop.background picture-uri-dark "file:///$image"

    else
        echo "[*] Unsupported desktop environment: $DESKTOP_SESSION"
    fi
}
