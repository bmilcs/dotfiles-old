#!/bin/sh

API="https://api.kraken.com/0/public/Ticker"


bitcoin=$(curl -sf $API?pair=BTCUSD | jq -r ".result.XXBTZUSD.c[0]")
bitcoin=$(LANG=C printf "%.2f" "$bitcoin")

#ethereum=$(curl -sf "$API?pair=ETHUSD" | jq -r ".result.XXETHUSD.c[0]")
#ethereum=$(LANG=C printf "%.2f" "$ethereum")

echo " \$$bitcoin" #  \$$ethereum "
