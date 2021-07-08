## BMILCS:HOMELAB

> HOMELAB TODO: workstations, laptops, servers, docker, virtualization and so forth.

## VIRTUALIZATION

* [ ] nextcloud
  * [ ] create ubuntu vm
  * [ ] consider postgresql over mariadb
    * [ ] (https://www.reddit.com/r/unraid/comments/fy7na5/nextcloud_login_and_navigation_extremely_slow/)

* [ ] nginx
  * [ ] public
    * [ ] create ubuntu vm
    * [ ] copy & convert swag to new config
    * [ ] change port forwarding

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