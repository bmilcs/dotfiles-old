#!/bin/bash
read -p 'Hostname: ' hosty

ssh-keygen -t rsa -b 4096 -f $HOME/.ssh/id_$hosty
# || echo "booooo" ; exit 1
	
echo "let's proceed..."

ssh-copy-id -f -o "IdentityFile ~/.ssh/id_bmilcs" -i $HOME/.ssh/id_$hosty bmilcs@$hosty || echo "DOH! copy-id fail"

eval `ssh-agent` && ssh-add -l || echo "couldn't add :("