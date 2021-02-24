#!/bin/sh

API="https://api.kraken.com/0/public/Ticker"

ethereum=$(curl -sf $API?pair=ETHUSD | jq -r ".result.XETHZUSD.c[0]")
ethereum=$(LANG=C printf "%.2f" "$ethereum")
#printf "\$%'.3f\n" $ethereum

bitcoin=$(curl -sf $API?pair=BTCUSD | jq -r ".result.XXBTZUSD.c[0]")
bitcoin=$(LANG=C printf "%.2f" "$bitcoin")

ethereum=$(printf "\$%'.0f\n" $ethereum)
bitcoin=$(printf "\$%'.0f\n" $bitcoin)
echo $ethereum " " $bitcoin

#ethereum=$(curl -sf "$API?pair=ETHUSD" | jq -r ".result.XXETHUSD.c[0]")
#ethereum=$(LANG=C printf "%.2f" "$ethereum")

#echo " \$$bitcoin" #  \$$ethereum "
