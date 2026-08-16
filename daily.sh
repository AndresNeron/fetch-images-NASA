#!/bin/bash

# This script is designed to be called from a systemctl timer in the host linux system.
# The purpose is to update the background with the latest image from the NASA.

export TERM=xterm-256color
export DISPLAY=:1
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"

PATH="/usr/local/cuda-12.9/bin:/home/ainode/miniforge3/bin:/home/ainode/miniforge3/condabin:/home/ainode/.nvm/versions/node/v22.17.1/bin:/usr/local/cuda-12.9/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt:."
CURRENT_PATH="$(dirname "$(realpath "$0")")"
PARENT_PATH="$(dirname "$CURRENT_PATH")"


daily(){

	# Receive the root path where is located the  main script from terminal.
	cd "$CURRENT_PATH" || return 1

	# Setup
	nasa_path="$CURRENT_PATH/fetch-images-NASA.sh"

	# Download until the last image.
	"$nasa_path" -d 25 > daily.log

	# Update the  background with the last image
	DISPLAY=:1 "$nasa_path" -l

	echo "[$(date)] executed $nasa_path -l" > change.log
}

daily
