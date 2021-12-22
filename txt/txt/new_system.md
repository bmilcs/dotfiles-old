# linux: new system setup

## hostname

    # hostname file
    sudo vim /etc/hostname
      "my_host"
      
    # hosts file
    sudo vim /etc/hosts
      127.0.0.1 localhost
      127.0.1.1 my_host.domain.local my_host
      
    # refresh
    . /etc/init.d/hostname.sh
