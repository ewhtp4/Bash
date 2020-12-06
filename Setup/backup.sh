#/bin/bash

bdate=$(date +%F)
#mkdir /mnt/backup
#mount /dev/nvme0n1p4 /mnt/backup
# Checks if there is a dir called Backup if not makes it
[ -d /media/ewhtp4/5EEE-DA67/Beckup ] || mkdir /media/ewhtp4/5EEE-DA67/Beckup

tar -czvf /media/ewhtp4/5EEE-DA67/Beckup/backup-${bdate}.tar.gz /home/ewhtp4/Documents
#umount /dev/nvme0n1p4

