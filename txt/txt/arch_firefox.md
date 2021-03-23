### bmilcs/firefox

#####  Change Performance settings

``` bash
browser.preferences.defaultPerformanceSettings.enabled    false
dom.ipc.processCount                                      8


media.hardware-video-decoding.force-enabled               true

```


##### ram cache setup

``` bash
# url:
about:config

# set:
browser.cache.disk.enable             true  # synced via profile-sync-daemon
browser.cache.memory.enable           true
browser.cache.memory.capacity         -1    # no limit
 
# install
sudo pacman -S profile-sync-daemon

# backup profile
bk ~/.mozilla

# generate conf
psd

# ~/.config/psd/psd.conf
# all browsers supported by default
BROWSERS=()
USE_OVERLAYFS="yes";

# enable/start psd service
# 1) closet firefox
# 2) enable start
systemctl --user enable psd
systemctl --user start psd

# preview psd status:
psd p

# ensure it's running:
ls /run/user/1086
... user-firefox-xxx.default
... user-qutebrowser/
... psd.pid


```



