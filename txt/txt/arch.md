## bmilcs/arch-install-cheatsheet
- [Official Installation guide](https://wiki.archlinux.org/index.php/Installation_guide#Prepare_the_storage_devices)

**CHECK BOOTMODE**: ``ls /sys/firmware/efi/efivars`` (error = CSM/BIOS, else UEFI)

**WIFI**: ``iwctl --passphrase *** station wlan0 connect SSID`` (verify w/ ``ip link`` and``ping archlinux.org``)

**FONT**: ``pacman -S terminus-font`` then ``setfont /usr/share/kbd/consolefonts/ter-122b.psf.gz``

**SYSTEM CLOCK**: ``timedatectl set-ntp true``

        pacman -Syyy
        # uncomment desired mirrors
        vim /etc/pacman.d/mirrorlist
        # re-update repository index
        pacman -Syyy


**PARTITIONING**:

        (c)fdisk -l
        (c)fdisk /dev/nvme0n1

