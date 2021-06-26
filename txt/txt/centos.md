### centos

post-install:

```
# add user/group
groupadd -g 1190 bmilcs \
  && useradd -u 1086 -g 1190 -G wheel bmilcs \
  && passwd bmilcs

# update/upgrade yum
yum update && yum upgrade

# install epel: extra packages enterprise linux (neovim, etc.)
yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm \
&& dnf config-manager --set-enabled powertools

# chsh -s
yum install -y util-linux-user git

# yum conf /etc/yum.conf
  [main]
  cachedir=/var/cache/yum/$basearch/$releasever
  keepcache=0
  debuglevel=2
  logfile=/var/log/yum.log
  exactarch=1
  obsoletes=1
  gpgcheck=1
  plugins=1 installonly_limit=5


```
