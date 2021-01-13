### pacman or not?


    #!/bin/bash
    CHECK_PAC=$(which pacman)
    if [[ ! -z $CHECK_PAC ]]; then
    echo 'error: arch-based distro. ignoring bmilcs-linux github.'
    fi
