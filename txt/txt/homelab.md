## BMILCS:HOMELAB

- [ ] backup irreplacable content 
- [ ] fix multi-monitor i3/xrandr
      [[arch_multimonitor](arch_multimonitor.md)](arch_multimonitor.md): multi-monitor
- [ ] make shanna on telegram notifications = purple
- [ ] freenas > kids vlan (erics nes roms)

> HOMELAB TODO: workstations, laptops, servers, docker, virtualization and so forth.

## MISC
* [ ] security camera: front yard
  * [ ] find position
  * [ ] install
* [ ] auto-update
  * [ ] on login: disable
  * [ ] implement cron job or ansible script

## VIRTUALIZATION

* [X] nginx project
  * [X] personal site: WWW
    * [X] setup lemp
    * [X] create vm
    * [X] move content over
    * [X] create npm redirect

* [X] nextcloud
  * [X] create ubuntu vm
  * [X] consider postgresql over mariadb
    * [X] (https://www.reddit.com/r/unraid/comments/fy7na5/nextcloud_login_and_navigation_extremely_slow/)

* [.] nginx
  * [.] public
    * [X] create ubuntu vm
    * [ ] copy & convert swag to new config
    * [ ] change port forwarding
    * [ ] harden security
    * [ ] https://www.cyberciti.biz/tips/linux-unix-bsd-nginx-webserver-security.html
      * [ ] selinux?
      * [ ] log monitoring?
      * [ ] notifications?
    * [ ] custom logging format
    * [ ] setup git repo

* [.] certificate authority (ca)
  * [ ] create ubuntu vm
  * [ ] install vault by hashicorp
  * [ ] origin ca certs via cloudflare
    * [X] https://developers.cloudflare.com/ssl/origin-configuration/origin-ca
    * [ ] is this what i want?

* [ ] database
  * [ ] consolidate all databases into a single vm

* [.] bitwarden
  * [X] https://www.reddit.com/r/bitwarden/comments/d4h4aj/best_way_to_mass_edit_bw_vault_data/
  * [ ] export to csv
  * [ ] reorganize into folders
  * [ ] deduplication
  * [ ] all lower case

* [ ] backup
  * [ ] fix / find solution
  * [ ] logrotate
  * [ ] rsnapreport
  * [ ] add hosts
    * [ ] bmpc
    * [ ] bmtp
    * [ ] docker
    * [ ] mpd
    * [ ] ???

* [ ] vpn (personal)
  * [ ] create ubuntu vm
  * [ ] setup wireguard server
  * [ ] setup wireguard client (phone, bmtp)

* [.] docker
  * [ ] network: secure, add local only
  * [ ] remote docker dev (rsync compose?)
  * [X] authentication all dockers
  * [ ] simplify, harden

## WORKSTATIONS

* [ ] vim
  * [ ] vimwiki
  * [ ] taskwarrior
  * [ ] https://github.com/vimwiki/vimwiki
* [ ] neomutt
  * [ ] install
  * [ ] configure
  * [ ] replace thunderbird entirely
* [ ] ncmpcpp
  * [ ] autosave playlist
  * [ ] hotkeys
* [ ] laptop: install manjaro
  * [ ] remove encryption
  * [ ] create 2nd partition for home/data
  * [ ] user-friendly for nana
* [ ] scripting
  * [ ] create hfr for gui interfaces/applications, ie: bitwarden
* [ ] break down into separate components
  * [ ] zsh
  * [ ] git
  * [ ] vim
  * [ ] opt, etc
* [ ] i3-wm
  - [ ] keybind: nvr security pop-up (req https)
  - [ ] keybind: selection copy/paste
* [ ] command research
  * [ ] awk
  * [ ] cut
  * [ ] xargs

## RESEARCH:
* [ ] swap to mullvad vpn ?
* [ ] email server
  * [ ] postfix+dovecot+spamassassin
  * [ ] domain email forwarding only?
* [ ] app.git-simple-login
* [ ] learn advanced bash https://learnxinyminutes.com/docs/bash/

## DOCKER [SERVARR]

* [ ] lidarr docker > beets integration
* [ ] musicbrainz / picard

### ANSIBLE

* [ ] debian deployment
* [ ] sshd_config
* [ ] authorized_keys
* [ ] change user/group id
* [ ] git clone dotfiles
* [ ] install essentials
* [ ] *sshd_config tweaks*
  * [ ] rsa key only
  * [ ] remove
    * [ ] Banner line
    * [ ] Root login
    * [ ] Password login
