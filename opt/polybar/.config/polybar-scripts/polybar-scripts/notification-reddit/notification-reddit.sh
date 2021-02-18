#!/bin/sh
URL="https://www.reddit.com/message/unread/.json?feed=db3141da529bf7ae8da6b50de7a300d660e01546&user=bmilcs"
USERAGENT="polybar-scripts/notification-reddit:v1.0 u/bmilcs"

notifications=$(curl -sf --user-agent "$USERAGENT" "$URL" | jq '.["data"]["children"] | length')

if [ -n "$notifications" ] && [ "$notifications" -gt 0 ]; then
    echo "$notifications"
else
    echo "0"
fi
