## BASH TRAPS

>SOURCE: https://mywiki.wooledge.org/SignalTrap

Name  | Number | Meaning
---|---|---
HUP | 1 | Hang Up. The controlling terminal has gone away.
INT | 2 | Interrupt: Ctrl-C or DEL via user
QUIT | 3 | Quit. The user has pressed the quit key (usually Ctrl-\). Exit and dump core.
KILL | 9 | Kill. This signal cannot be caught or ignored. Unconditionally fatal. No cleanup possible.
TERM | 15 | Terminate. This is the default signal sent by the kill command.
EXIT | 0 | BASH: Run on **any exit**, **SIGNALLED OR NOT**.  OTHER POSIX SHELLS: only when the shell process exits. 

## EXAMPLES

#### Clean up temporary files:

``` bash
#!/bin/bash
tempfile=$(mktemp) || exit
trap 'rm -f "$tempfile"' EXIT
...
```

#### Re-Read Configuration File on SIGHUP (1 hang up)
> long-running daemon processes prevent having to restart from scratch when
configuration variable is changed

``` bash
# !/bin/bash
config=/etc/myscript/config
read_config() { test -r "$config" && . "$config"; }
read_config
trap 'read_config' HUP
while true; do
```


