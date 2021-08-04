# I3 MULTI-MONITOR

## I3 GAPS

> I3 has no built-in multi-conf support

- [ ] divide .config/i3/config into multiple parts
- [ ] install.sh
  - [ ] determine host name or hardware type
  - [ ] if bmPC, add core.conf + bmPC.conf, cat to config (seen below)
  - [ ] if bmTP, add core.conf + bmTP.conf, cat to config (seen below)

``` sh
cat ~/.config/i3/config.1 > ~/.config/i3/config
cat ~/.config/i3/config.2 >> ~/.config/i3/config
```

### bmTP && bmPC

- workspace settings
- floating window settings
