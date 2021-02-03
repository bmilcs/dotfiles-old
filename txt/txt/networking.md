# arch linux networking guide


##### optional: wifi package

    sudo pacman -S iwd

##### create *.network cfg files

    sudo vim /etc/systemd/network/00-bmilcs.conf
    -------------------------------------------------------
    [Match]
    Name=enp* wl*

    [Network]
    DHCP=ipv4

##### symlink resolv.conf

    sudo ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

##### enable/start systemd services

    # ETHERNET + WIFI
    sudo systemctl enable {systemd-networkd.service,systemd-resolved.service,iwd.service}
    sudo systemctl start {systemd-networkd.service,systemd-resolved.service,iwd.service}

    # ETHERNET ONLY 
    sudo systemctl enable {systemd-networkd.service,systemd-resolved.service,iwd.service}
    sudo systemctl start {systemd-networkd.service,systemd-resolved.service,iwd.service}

##### troubleshooting

- networkctl

      networkctl list
      networkctl forcerenew
      networkctl reload
      networkctl reconfigure

- resolvectl 

      resolvectl status
      resolvectl flush-caches
      resolvectl statistics
