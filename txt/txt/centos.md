### centos

post-install:

```
groupadd -g 1190 bmilcs \
  && useradd -u 1086 -g 1190 -G wheel bmilcs \
  && passwd bmilcs

yum update && yum upgrade

# install epel: extra packages enterprise linux (neovim, etc.)
yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm \
&& dnf config-manager --set-enabled powertools

# chsh -s
yum install -y util-linux-user zsh git

```
