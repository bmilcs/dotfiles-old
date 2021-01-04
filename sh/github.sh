# download existing repo
git clone https://github.com/blimcs/dotfiles
cd dotfiles

# backup the current repo
git branch -c main backup_2020-01
git push origin backup_2020-01

# then if you want to git clone it you can use
git clone https://github.com/blimcs/dotfiles -b backup_2020-01

# and to switch on an existing repo
# download it from github
git fetch --all
# switch branch (WARNING: your uncommited changes will likely be removed)
git checkout backup_2020-01

