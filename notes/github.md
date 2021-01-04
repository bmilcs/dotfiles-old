#### NOTES/GITHUB.MD

##### common fixes

    git remote set-url origin git@github.com:bmilcs/dotfiles.git
    git config --global credential.helper store

#### list files

> *current files for branch*

    git ls-tree -r master --name-only

> *historical list (ever)*

    git log --pretty=format: --name-only --diff-filter=A | sort - | sed '/^$/d'


#### branches <sup>[[1]](#gtk)</sup>

*version control: creating backups*


    # download existing repo
    git clone https://github.com/blimcs/dotfiles
    cd dotfiles

    # backup the current repo
    git branch -c main backup_2020-01
    git push origin backup_2020-01

    # git clone it 
    git clone https://github.com/blimcs/dotfiles -b backup_2020-01

    # switch on an existing repo / download it from github
    git fetch --all

    # switch branch (WARNING: your uncommited changes will likely be removed)
    git checkout backup_2020-01

**<a name="gtk"><sup>**[1]**</sup></a> @gtk irc unixporn 2020-01-04**
