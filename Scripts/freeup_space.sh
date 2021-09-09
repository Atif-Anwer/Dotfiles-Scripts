 #!/bin/bash

du -sh /var/cache/apt/archives
sudo apt-get clean
sudo apt-get autoremove --purge
sudo journalctl --vacuum-time=3d
rm -rf ~/.cache/thumbnails/*


# Removes old revisions of snaps
# CLOSE ALL SNAPS BEFORE RUNNING THIS
set -eu
snap list --all | awk '/disabled/{print $1, $3}' |
    while read snapname revision; do
        snap remove "$snapname" --revision="$revision"
    done
