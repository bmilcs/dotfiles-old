# NFS TIPS

### creating mount points

    sudo mkdir /path
    chattr +i /path

    /etc/fstab
    host:remotepath /path nfs auto,x-systemd.automount,x-systemd.device-timeout=10,timeo=14,x-systemd.idle-timeout=1min 0 0

# creating shares

      sudo apt install nfs-kernel-server
      sudo nano /etc/exports

      "/path/to the/dir"	10.1.1.0/24(rw,sync,no_subtree_check)

      sudo systemctl restart nfs-kernel-server

      sudo systemctl status nfs-kernel-server

