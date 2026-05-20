#!/bin/bash

# Sync music library to server
# Usage: ./sync-music.sh /path/to/music user@server-ip

SOURCE=$1
DEST=$2

if [ -z "$SOURCE" ] || [ -z "$DEST" ]; then
    echo "Usage: ./sync-music.sh /path/to/music user@server-ip"
    exit 1
fi

rsync -av --progress "$SOURCE/" "$DEST:/opt/media/music/"
echo "Sync complete. Trigger a scan in Navidrome to pick up new music."
