#!/bin/bash

rsync -aAXvP /* /mnt --exclude={/dev/*,/proc/*,/sys/*,/tmp/*,/run/*,/mnt/*,/media/*,/lost+found,/.gvfs}

cp -avT /run/archiso/bootmnt/arch/boot/$(uname -m)/vmlinuz /mnt/boot/vmlinuz-linux

sed -i 's/Storage=volatile/#Storage=auto/' /mnt/etc/systemd/journald.conf

rm /mnt/etc/udev/rules.d/81-dhcpcd.rules

rm /mnt/root/{.automated_script.sh,.zlogin}

rm -r /mnt/etc/systemd/system/{choose-mirror.service,pacman-init.service,etc-pacman.d-gnupg.mount,getty@tty1.service.d}

rm /mnt/etc/systemd/scripts/choose-mirror

chmod 700 /mnt/root

genfstab -U -p /mnt >> /mnt/etc/fstab && cat /mnt/etc/fstab

arch-chroot /mnt /bin/bash -c "curl -s -o chroot_jobs.sh https://github.com/virtualdemon/archx/master/chroot_jobs.sh && chmod +x chroot_jobs.sh && ./chroot_jobs.sh"
