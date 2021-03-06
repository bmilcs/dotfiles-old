# BASH

### User

- `~/.bash_profile` should be super-simple: load `.profile` THEN `.bashrc` (in that order)

~/.profile has the stuff NOT specifically related to bash, such as environment variables (PATH and friends)

~/.bashrc has anything you'd want at an interactive command line. Command prompt, EDITOR variable, bash aliases for my use

Anything that should be available to graphical applications OR to sh (or bash invoked as sh) MUST be in ~/.profile

~/.bashrc must not output anything

Anything that should be available only to login shells should go in ~/.profile

Ensure that ~/.bash_login does not exist.


- `[~/.bash_profile]` personal initialization file, executed for login shells
- `[~/.bashrc]` individual per-interactive-shell startup file

### System wide 
> functions/aliases, even for non-interactive, non-login shells
- `[/etc/bash.bashrc]` (Arch)
- `[/etc/bashrc]` (Redhat, Fedora, etc)
- `[/etc/bash.bashrc]` (Debian, Ubuntu, Linux Mint, Backtrack, Kali etc)
- `[/etc/bash.bashrc.local]` (Suse, OpenSuse, etc)

