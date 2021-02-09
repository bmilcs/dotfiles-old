
source https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup
## gitconfig 
order in which settings hold the most weight 

  1. **repo**:    `.git/config` king - trumps all others

  1. **user**:    `~/.gitconfig`, `~/.config/git/config` queen - trumped by repo, trumps system

  1. **system**:  `/etc/gitconfig` jack - trumped by user and repo

## configuring git

**note:** to view all settings and where they come from, use ``$ git config --list --show-origin`` 

identity (``--global`` makes it system wide, never requiring it again)

    $ git config --global user.name "bmilcs"
    $ git config --global user.email "bmilcs@yahoo.com"

editor

    $ git config --global core.editor nvim

default branch name

    $ git config --global init.defaultBranch main

## help 

    git <verb> -h
    git <verb> --help
    git help <verb>
    man git-<verb>

ie: git config help would be `git config -h`

## obtaining a git repo

creating new repositories

```git
git init
git add *.c
git add LICENSE
git commit -m 'Initial project version'
```
- `git init` creates .git/, the git repository skeleton.
- `git add` begins version control on said file
- `git commit` commits staged files to the database

cloning others' repositoris

## clone

`git clone url (dest)` obtains the **entire history of the project** by default

git uses several transfer protocols: `https`, `ssh`, `git://`

ssh format is `user@server:path/repo.git`

## recording changes to the repo

everything inside your working directory is either ``tracked`` or ``untracked``

`tracked` files were in the last snapshot: unmodified, modified, or staged.

`untracked` files were **not** in the last snapshot & not in your staging area

## checking file status

    $ git status

- modifications to tracked files 
- new untracked files
- branch you're on
- if diverged from remote branch

for a less wordy version, use: 

    $ git status -s

    M   modified
    MM  modified, staged, modified again
    A   lib/git.rb
    M   modified
    ??  untracked 

## tracking new files

    $ git add FILE
    $ git add DIR     # adds directory & all of it's contents

`$ git add` has many uses:
- begins tracking file
- stages file to be committed 
  - if you commit now, the version of the file **when** `git add` **was run** is snapshotted
- mark merge-conflicted files as resolved

**`git add`** means "**Add precisely THIS content to the next commit**"

## ignoring files

    $ cat .gitignore

    *.[oa]    any files ending in .o or .a
    *~        all files ending with tilde (emac temp files)

other common additions: `log tmp pid`

    x/        directories
    /x        not recursive
    !x        negate a pattern (don't ignore)

standard glob patterns (simplified regular expressions)

    *         zero or more chars
    ?         any single char
    [abc]     any char inside bracket
    [0-9]     range 
    a/**z/    nested directories
              matches: a/z, a/b/z, a/b/c/z

examples

    # ignore all .a files
    *.a
    # but do track lib.a, even though you're ignoring .a files above
    !lib.a
    # only ignore the TODO file in the current directory, not subdir/TODO
    /TODO
    # ignore all files in any directory named build
    build/
    # ignore doc/notes.txt, but not doc/server/arch.txt
    doc/*.txt
    # ignore all .pdf files in the doc/ directory and any of its subdirectories
    doc/**/*.pdf

## viewing staged/unstaged changes

`$ git diff` 
- working directory vs staging area
- shows changes that aren't staged yet

`$ git diff --staged`
- staged changes vs last commit


