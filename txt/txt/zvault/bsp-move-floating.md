## bspwm move floating windows
    
    #!/bin/bash
    desktop=$(bspc query -D -d any.focused --names)
    offset=0
    [[ $desktop -gt 5 ]] && offset=1920
    if [[ $1 == 'left_bottom' ]]; then
        bspc node -t floating; xdo resize -w 500 -h 300; xdo move -x $((20+offset)) -y 760
    elif [[ $1 == 'right_bottom' ]]; then
        bspc node -t floating; xdo resize -w 500 -h 300; xdo move -x $((1400+offset)) -y 760
    elif [[ $1 == 'middle_big' ]]; then
        bspc node -t floating ; xdo move -x $((240+offset)) -y 135 ; xdo resize -w 1440 -h 810
    elif [[ $1 == 'middle_small' ]]; then
        bspc node -t floating; xdo resize -w 960 -h 540; xdo move -x $((480+offset)) -y 270
    fi
