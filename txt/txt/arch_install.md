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


 https://tonisagrista.com/blog/2020/arch-encryption/
 initcp = wrong. 
 mount wrong. use /dev/mapper

**MAKEPKG**

https://wiki.archlinux.org/index.php/makepkg#Parallel_compilation
https://wiki.archlinux.org/index.php/makepkg#Utilizing_multiple_cores_on_compression


Building from files in memory

  /etc/fstab
  tmpfs   /tmp         tmpfs   rw,nodev,nosuid,size=2G          0  0

  $ BUILDDIR=/tmp/makepkg makepkg


Use other compression algorithms

  To speed up both packaging and installation, with the tradeoff of having larger package archives, you can change PKGEXT. 
  $ PKGEXT='.pkg.tar' makepkg

  As another example, the following uses the lzop algorithm, with the lzop package required:
  $ PKGEXT='.pkg.tar.lzo' makepkg


Utilizing multiple cores on compression

  yay -S xz
  makepkg use as many CPU cores as possible to compress packages
  COMPRESSXZ=(xz -c -z - --threads=0)








/etc/iwd/main.conf

    [General]
    EnableNetworkConfiguration=true

    [Network]
    NameResolvingService=systemd

/etc/systemd/network/25-wireless.network

    [Match]
    Name=wlp2s0

    [Network]
    DHCP=yes

systemctl enable systemd-networkd.service
systemctl start  systemd-networkd.service
systemctl enable systemd-resolved.service
systemctl enable systemd-resolved.service
systemctl enable wtctl.service
systemctl start  wtctl.service

---

dpkg -s "${reqs[@]}" >/dev/null 2>&1 || ( sudo apt-get install ${reqs[@]} && _s installed ${reqs[@]})
