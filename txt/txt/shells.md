# SHELL FILES

### USER
#### **`~/.bash_profile`** 
  - super-simple
  - load `.profile` THEN `.bashrc` 

#### **`~/.profile`**
  - `ENVIRONMENT VARIABLES ($PATH, ETC.)`
  - NOT limited to just bash (ie: zsh)
  - anything you want available to:
    1. sh
    1. login shells
    1. bash invoked as sh
    1. graphical applications

#### **`~/.bashrc`** 
  - *interactive* command line. 
  - Command prompt, EDITOR variable, bash aliases for my use
  - `~/.bashrc` must not output anything

#### Ensure that ~/.bash_login does not exist.

### SYSTEM WIDE 
> functions/aliases, even for non-interactive, non-login shells
- `[/etc/bash.bashrc]` (Arch)
- `[/etc/bashrc]` (Redhat, Fedora, etc)
- `[/etc/bash.bashrc]` (Debian, Ubuntu, Linux Mint, Backtrack, Kali etc)
- `[/etc/bash.bashrc.local]` (Suse, OpenSuse, etc)

----
# Sourced files 

### LOGIN SHELL
#### Bourne-Compatible shells
/etc/profile and ~/.profile for Bourne compatible shells (and /etc/profile.d/*) ~/.bash_profile for bash /etc/zprofile and ~/.zprofile for zsh /etc/csh.login and ~/.login for 



----


