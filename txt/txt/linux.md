# arguments/parameters of scripts/functions

| var  | desc                                                             |
| ---- | :--------------------------------------------------------------- |
| $#   | # of arguments                                                   |
| $?   | exit status, last command (0=true/success)                       |
| $0   | first word of entered command (the name of the shell program)    |
| $\*  | all arguments command line ($1 $2 ...).                          |
| "$@" | all arguments command line, individually quoted ("$1" "$2" ...). |

---

# IF... ELSE

**SYNTAX**

```
    [[ 1 -eq 1 ]] && echo "duh!"
    [[ 1 -eq 2 ]] || echo "of course not!"

    if [[ 1 -eq 2 ]]
    then
    elif
    fi

    if [[ 1 -eq 2 ]]; then
    fi


    if [[ 1 -eq 2 ]]; then gogogo; fi
    fi
```

# TEST COMMAND (IF)

**SYNTAX**

    test EXPRESSION
    [ expression ]
    test
    [ ]

### EXPRESSIONS

| EXPRESSION             | ...                 |
| ---------------------- | ------------------- |
| **(** exp **)**        | expression is true  |
| **!** exp              | expression is false |
| e1 **-a** e2           | AND: both true      |
| e1 **&&** e2           | AND: both true      |
| e1 **-o** e2           | OR: 1 is true       |
| e1 **&#124;&#124;** e2 | OR: 1 is true       |

### STRINGS

| STRINGS           | ...                                             |
| ----------------- | ----------------------------------------------- |
| **-n** str        | string length is NON-zero                       |
| **-z** str        | string length IS zero                           |
| s1 **=** s2       | strings are equal, pattern matching             |
| [[s1 **=** "s2"]] | strings are equal, literal, NO pattern matching |
| s1 **!=** s2      | strings NOT are equal                           |
| c > a             | true: c comes after a (greater value)           |
| c < a             | false: a comes before c (less than)             |
| [[$NAME = derp*]] | wildcard matching                               |

### INTEGERS

| INTEGERS    | ...                     |
| ----------- | ----------------------- |
| x **-eq** y | integers equal          |
| x **-ge** y | greater/equal: i1 >= i2 |
| x **-gt** y | greater: i1 > i2        |
| x **-le** y | lesser/equal: i1 <= i2  |
| x **-lt** y | lesser: i1 < i2         |
| x **-ne** y | NOT equal to: i1 != i2  |

### FILES/DIRS

|       FILES | DEF                       | IE                      |
| ----------: | :------------------------ | :---------------------- |
|      **-f** | True: is a regular File.  | [[-f demofile]]         |
|      **-d** | True: is a Directory.     | [[-d demofile]]         |
|      **-e** | True: file/dir exists.    | [[-e demofile]]         |
|      **-h** | True: is a symbolic Link. | [[-h demofile]]         |
|      **-L** | True: is a symbolic Link. | [[-L demofile]]         |
|      **-G** | True: owned by group id.  | [[-G demofile]]         |
|      **-O** | True: owned by user id.   | [[-O demofile]]         |
|      **-r** | True: is readable.        | [[-r demofile]]         |
|      **-w** | True: is writable.        | [[-w demofile]]         |
|      **-x** | True: is executable.      | [[-x demofile]]         |
| x **-nt** y | True x is newer than y.   | [[demofile1 -nt $DEMO]] |
| x **-ot** y | True x is older than y.   | [[$DEMO -ot demofile2]] |

# CASE

> elegant if/then

    case $ANIMAL in
      (horse | dog | cat) legs=four;;
      (man | kangaroo ) legs=two;;
      (*) echo -n legs="an unknown number of";;
    esac

# LOOPS

### FOR

> all files in current directory

      for d in * ; do

### WHILE

---

# SED

##### variable

example: $PATH

> "/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games"

> "/usr/local/bin /usr/bin /bin /usr/local/games /usr/games"

    1) sed 's/:/ /g' <<<"$PATH"
    2) echo "$PATH" | sed 's/:/ /g'

    # without SED

      3) echo "${PATH//:/ }"
      4) echo "${var//pat/rep}"

    x="$PATH"
    x="$(echo $x | sed 's/:/ /g')"
    echo "$x"

##### regex with retention

    DBSERVERNAME    xxx
    to
    DBSERVERNAME    yyy

    sed -rne 's/(dbservername)\s+\w+/\1 yyy/gip'

- `-r` regex w/o escape chars
- `-n` does not print unless specified - `sed` prints by default otherwise,
- `-e` means what follows it is an expression. Let's break the expression down:
  - `s///` is the command for search-replace, and what's between the first pair is the regex to match, and the second pair the replacement,
  - `gip`, which follows the search replace command
    - `g` means global, i.e., every match instead of just the first will be replaced in a line;
    - `i` is case-insensitivity;
    - `p` print when done (remember the `-n` flag from earlier!),
  - The brackets represent a match part, which will come up later. So `dbservername` is the first match part,
  - `\s` is whitespace, `+` means one or more (vs `*`, zero or more) occurrences,
  - `\w` is a word, that is any letter, digit or underscore,
  - `\1` is a special expression for GNU `sed` that prints the first bracketed match in the accompanying search.

---

# INPUT OUTPUT REDIRECTS

[**source**](https://gist.github.com/bmilcs/a51512131d44077a6ee2db818ccb6dca)

|       example | def                                                      |
| ------------: | -------------------------------------------------------- |
|    1 &#124; 2 | use stdout of cmd1 as stdin for cmd2                     |
|        > file | save stdout to file                                      |
|        < file | use file as stdin                                        |
|       >> file | append stdout to file (create file if nonexistent)       |
|  >&#124; file | force stdout to file (even if noclobber is set)          |
| n>&#124; file | force stdout to file from descriptor n (even...)         |
|       <> file | use file as both stdin and stdout (process in place)     |
|      n<> file | use as both stdin and stdout for file descriptor n       |
|      << label | use here-document (within scripts specifies batch input) |
|       n> file | direct file descriptor n to file                         |
|       n< file | take file descriptor n from file                         |
|      n>> file | append descriptor n to file (or create file for n)       |
|           n>& | duplicate stdout to file descriptor n                    |
|           n<& | duplicate stdin from file descriptor n                   |
|          n>&m | make file descriptor n a copy of the stdout fd           |
|          n<&m | make file descriptor n a copy of the stdin fd            |
|        >&file | send stdout and stderror to file                         |
|           <&- | close stdin                                              |
|           >&- | close stdout                                             |
|          n<&- | close input from file descriptor n                       |
|          n>&- | close output from file descriptor n                      |

---

# LINUX OPERATORS

## A. Control operators

[POSIX definition](https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap03.html#tag_03_113)

> In the shell command language, a token that performs a control function.  
> It is one of the following symbols:

>     &   &&   (   )   ;   ;;   <newline>   |   ||

And `|&` in bash.

A `!` is **not** a control operator but a [Reserved Word](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_04). It becomes a logical NOT [negation operator] inside [Arithmetic Expressions](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap01.html#tag_17_01_02) and inside test constructs (while still requiring an space delimiter).

### A.1 List terminators

- `;` : Will run one command after another has finished, irrespective of the outcome of the first.

        command1 ; command2

First `command1` is run, in the foreground, and once it has finished, `command2` will be run.

A newline that isn't in a string literal or after certain keywords is _not_ equivalent to the semicolon operator. A list of `;` delimited simple commands is still a _list_ - as in the shell's parser must still continue to read in the simple commands that follow a `;` delimited simple command before executing, whereas a newline can delimit an entire command list - or list of lists. The difference is subtle, but complicated: given the shell has no previous imperative for reading in data following a newline, the newline marks a point where the shell can begin to evaluate the simple commands it has already read in, whereas a `;` semi-colon does not.

- `&` : This will run a command in the background, allowing you to continue working in the same shell.

         command1 & command2

Here, `command1` is launched in the background and `command2` starts running in the foreground immediately, without waiting for `command1` to exit.

A newline after `command1` is optional.

### A.2 Logical operators

- `&&` : Used to build AND lists, it allows you to run one command only if another exited successfully.

  command1 && command2

Here, `command2` will run after `command1` has finished and _only_ if `command1` was successful (if its exit code was 0). Both commands are run in the foreground.

This command can also be written

        if command1
        then command2
        else false
        fi

or simply `if command1; then command2; fi` if the return status is ignored.

- `||` : Used to build OR lists, it allows you to run one command only if another exited unsuccessfully.

         command1 || command2

Here, `command2` will only run if `command1` failed (if it returned an exit status other than 0). Both commands are run in the foreground.

This command can also be written

        if command1
        then true
        else command2
        fi

or in a shorter way `if ! command1; then command2; fi`.

Note that `&&` and `||` are left-associative; see https://unix.stackexchange.com/questions/88850/precedence-of-the-shell-logical-operators for more information.

- `!`: This is a reserved word which acts as the “not” operator (but must have a delimiter), used to negate the return status of a command — return 0 if the command returns a nonzero status, return 1 if it returns the status 0. Also a logical NOT for the `test` utility.

        ! command1

        [ ! a = a ]

And a true NOT operator inside Arithmetic Expressions:

        $ echo $((!0)) $((!23))
        1 0

### A.3 Pipe operator

- `|` : The pipe operator, it passes the output of one command as input to another. A command built from the pipe operator is called a [pipeline](<http://en.wikipedia.org/wiki/Pipeline_(Unix)>).

         command1 | command2

  Any output printed by `command1` is passed as input to `command2`.

- `|&` : This is a shorthand for `2>&1 |` in bash and zsh. It passes both standard output and standard error of one command as input to another.

        command1 |& command2

### A.4 Other list punctuation

`;;` is used solely to mark the end of a [case statement](https://www.gnu.org/software/bash/manual/bashref.html#Conditional-Constructs). Ksh, bash and zsh also support `;&` to fall through to the next case and `;;&` (not in ATT ksh) to go on and test subsequent cases.

`(` and `)` are used to [group commands](https://www.gnu.org/software/bash/manual/bashref.html#Command-Grouping) and launch them in a subshell. `{` and `}` also group commands, but do not launch them in a subshell. See [this answer](https://stackoverflow.com/questions/6270440/simple-logical-operators-in-bash/6270803#6270803) for a discussion of the various types of parentheses, brackets and braces in shell syntax.

## B. Redirection Operators

[POSIX definition of Redirection Operator](https://pubs.opengroup.org/onlinepubs/9699919799.2016edition/basedefs/V1_chap03.html#tag_03_318)

> In the shell command language, a token that performs a redirection function. It is one of the following symbols:

>     <     >     >|     <<     >>     <&     >&     <<-     <>

These allow you to control the input and output of your commands. They can appear anywhere within a simple command or may follow a command. Redirections are processed in the order they appear, from left to right.

- `<` : Gives input to a command.

        command < file.txt

The above will execute `command` on the contents of `file.txt`.

- `<>` : same as above, but the file is open in _read+write_ mode instead of _read-only_:

        command <> file.txt

If the file doesn't exist, it will be created.

That operator is rarely used because commands generally only _read_ from their stdin, though [it can come handy in a number of specific situations](https://unix.stackexchange.com/a/164449).

- `>` : Directs the output of a command into a file.

        command > out.txt

The above will save the output of `command` as `out.txt`. If the file exists, its contents will be overwritten and if it does not exist it will be created.

This operator is also often used to choose whether something should be printed to [standard error](http://en.wikipedia.org/wiki/Standard_streams#Standard_error_.28stderr.29) or [standard output](http://en.wikipedia.org/wiki/Standard_streams#Standard_output_.28stdout.29):

        command >out.txt 2>error.txt

In the example above, `>` will redirect standard output and `2>` redirects standard error. Output can also be redirected using `1>` but, since this is the default, the `1` is usually omitted and it's written simply as `>`.

So, to run `command` on `file.txt` and save its output in `out.txt` and any error messages in `error.txt` you would run:

        command < file.txt > out.txt 2> error.txt

- `>|` : Does the same as `>`, but will overwrite the target, even if the shell has been configured to refuse overwriting (with `set -C` or `set -o noclobber`).
  command >| out.txt

If `out.txt` exists, the output of `command` will replace its content. If it does not exist it will be created.

- `>>` : Does the same as `>`, except that if the target file exists, the new data are appended.
  command >> out.txt

If `out.txt` exists, the output of `command` will be appended to it, after whatever is already in it. If it does not exist it will be created.

- `>&` : (per POSIX spec) when surrounded by **digits** (`1>&2`) or `-` on the right side (`1>&-`) either redirects only **one** file descriptor or closes it (`>&-`).

A `>&` followed by a file descriptor number is a portable way to redirect a file descriptor, and `>&-` is a portable way to close a file descriptor.

If the right side of this redirection is a file please read the next entry.

- `>&`, `&>`, `>>&` and `&>>` : (read above also) Redirect both standard error and standard output, replacing or appending, respectively.

        command &> out.txt

Both standard error and standard output of `command` will be saved in `out.txt`, overwriting its contents or creating it if it doesn't exist.

        command &>> out.txt

As above, except that if `out.txt` exists, the output and error of `command` will be appended to it.

The `&>` variant originates in `bash`, while the `>&` variant comes from csh (decades earlier). They both conflict with other POSIX shell operators and should not be used in portable `sh` scripts.

- `<<` : A here document. It is often used to print multi-line strings.

         command << WORD
             Text
         WORD

  Here, `command` will take everything until it finds the next occurrence of `WORD`, `Text` in the example above, as input . While `WORD` is often `EoF` or variations thereof, it can be any alphanumeric (and not only) string you like. When `WORD` is quoted, the text in the here document is treated literally and no expansions are performed (on variables for example). If it is unquoted, variables will be expanded. For more details, see the [bash manual](https://www.gnu.org/software/bash/manual/bashref.html#Here-Documents).

  If you want to pipe the output of `command << WORD ... WORD` directly into another command or commands, you have to put the pipe on the same line as `<< WORD`, you can't put it after the terminating WORD or on the line following. For example:

         command << WORD | command2 | command3...
             Text
         WORD

- `<<<` : Here strings, similar to here documents, but intended for a single line. These exist only in the Unix port or rc (where it originated), zsh, some implementations of ksh, yash and bash.

        command <<< WORD

Whatever is given as `WORD` is expanded and its value is passed as input to `command`. This is often used to pass the content of variables as input to a command. For example:

     $ foo="bar"
     $ sed 's/a/A/' <<< "$foo"
     bAr
     # as a short-cut for the standard:
     $ printf '%s\n' "$foo" | sed 's/a/A/'
     bAr
     # or
     sed 's/a/A/' << EOF
     $foo
     EOF

A few other operators (`>&-`, `x>&y` `x<&y`) can be used to close or duplicate file descriptors. For details on them, please see the relevant section of your shell's manual ([here](https://www.gnu.org/software/bash/manual/bashref.html#Moving-File-Descriptors) for instance for bash).

That only covers the most common operators of Bourne-like shells. Some shells have a few additional redirection operators of their own.

Ksh, bash and zsh also have constructs `<(…)`, `>(…)` and `=(…)` (that latter one in `zsh` only). These are not redirections, but [process substitution](http://www.gnu.org/software/bash/manual/bash.html#Process-Substitution).

---

# AUTOCOMPLETE

##### [zfs/compctl](https://stackoverflow.com/questions/14287887/custom-zsh-completion-based-on-multiple-paths) (working)

- literal completions

      compctl -k "(foo bar baz)" mycmd

- array completions

      compctl -/ -W "(/.../otherdir /.../somedir)" mycmd
      compctl -/ -W "($HOME/bm)" mycmd

---

##### bash/zfs - untested

[**source1**](https://stackoverflow.com/questions/39624071/autocomplete-in-bash-script)
[**source2**](https://stackoverflow.com/questions/4791642/find-based-filename-autocomplete-in-bash-script/12025812#12025812)

    # this is a custom function that provides matches for the bash autocompletion
    _dot_complete() {
        local file

        # iterate all files in a directory that start with our search string
        for file in ~/bm/"$2"*; do

            # If the glob doesn't match, we'll get the glob itself, so make sure
            # we have an existing file. This check also skips entries
            # that are not a directory
            [[ -d $file ]] || continue

            # add the file without the ~/Desktop/_REPOS/ prefix to the list of
            # autocomplete suggestions
            COMPREPLY+=( $(basename "$file") )

        done
    }

    # this line registers our custom autocompletion function to be invoked
    # when completing arguments to the repo command
    complete -F _dot_complete repo

    # Bash
    complete -F <completion_function> notes
    # Zsh
    compctl -K <completion_function> notes

---

#### [zfs zstyle & compdef](https://unix.stackexchange.com/questions/27236/zsh-autocomplete-ls-command-with-directories-only)

If you always want to complete directory names only for `ls`, you can put this in your `.zshrc`:

    compdef _dirs ls

You can do fancier stuff with the “new” completion system (initialized by `compinit`) by playing with [styles](http://zsh.sourceforge.net/Doc/Release/Completion-System.html#Standard-Styles). Depending on your options, you may need to `unalias ls`. Then, to only ever complete directories on the `ls` command line:

    zstyle ':completion:*:ls:*' file-patterns '*(/):directories'

You can complete only directories by default, but complete any file name if no directory matches:

    zstyle ':completion:*:ls:*' file-patterns '%p:globbed-files' '*(/):directories'

You can also define a key binding to complete only directories, which you can then use anywhere.

    zle -C complete_dirs .complete-word _dirs
    bindkey '^X/' complete_dirs

---

### SHEBANG @gk

`#! /path/to/stuff` tells the computer what to run the script in (space is optional), so #!/usr/bin/env python3 will tell the computer to run the rest of the script in python3

`/usr/bin/env` looks in the PATH variable, so you should use it for everything except sh (not bash!) which should always be /bin/sh

`/bin/sh` is usually a symlink

`bash` isn't guaranteed to be in `/bin`

there are 2 things that a unix system will always have in a specific path:

- `/bin/sh`
- `/usr/bin/env` (can be used for everything else)

`sh` is what `bash` added to

a lot of modern linux distros have sh symlinked to bash, but that is incorrect.

bash has a few things that break posix sh (one example that comes to mind is echo in bash needing -e to act like it does in posix)

**vim**

- syntax checking: Plug 'dense-analysis/ale'
- coc: completion
- spellcheck: cli program ale uses for shell warnings, including shebangs, poor syntax

      # zstyle ':completion:*:stw:*' file-patterns '*(/):directories'

      # lists everything
      compdef '_files -g "$HOME/bm/*"' stw

### useradd

  `useradd` arguments:
  `-u 1086` specify user id
  `-g 1190` specify group id
  `-G wheel,etc` specify supplementary groups 


#### REFERENCES

- [**Linuxize: Bash Functions**](https://linuxize.com/post/bash-functions/)
- [**Stackoverflow: Autocomplete @ specific dir**](https://stackoverflow.com/questions/57426500/list-directories-at-a-specific-path-as-autocomplete-options-for-a-bash-script)


# Linux Notes (Very Beginning)

> I moved to Archlinux full-time in December of 2020. The migration from Debian-based VM's to a pacman-centric workstation required a fresh start. Come take a look:

### [dot.bmilcs.com](https://dot.bmilcs.com)

---

###### install dotfiles, scripts, etc.

    (sudo apt install git ; rm -rf ~/_bmilcs ~/.bm* ~/.inputr* ; git clone https://github.com/bmilcs/linux.git ~/.bmilcs ; chmod -R +x ~/.bmilcs/* ; /bin/bash ~/.bmilcs/dotfiles/install.sh ; source ~/.bashrc)

# rsync

compare copied data and export missing content to log

      rsync -avun --no-group --no-owner --no-perms --no-times /original/nas/dir/ user@newhost:/new/nas/dir/ >> bmilcs_missing.log

      # save output to a file, as it takes a while with huge amounts of data and if you're like me, you'll forget you ran it.
      >> bmilcs.log

- Make sure /original/nas/dir/ has trailing / (supposedly this is important)
- Here's a breakdown:

rsync - | desc
--|--
n | dry-run (DONT CHANGE SHIT)
a | archive (recursive, preserve everything)
v | verbose (speak up)
u | update (skip any files which exists in destination)
no-group | ignore mismatching groups
no-owner | ignore mismatching owners
no-perms | ignore mismatching perms
no-times | ignore mismatching times

# cron

      crontab -e

pos | time | example
--|--|--
1 |	Minute |	0 to 59, or * (no specific value)
2 |	Hour 	|0 to 23, or * for any value. All times UTC.
3 |	Day of the month 	|1 to 31, or * (no specific value)
4 |	Month |	1 to 12, or * (no specific value)
5 |	Day of the week |	0 to 7 (0 and 7 both represent Sunday), or * (no specific value)

Cron time string 	| Description
--|--
30 * * * *| 	Execute a command at 30 minutes past the hour, every hour.
0 13 * * 1 |	Execute a command at 1:00 p.m. UTC every Monday.
*/5 * * * * |	Execute a command every five minutes.
0 */2 * * * |	Execute a command every second hour, on the hour.

# nfs file sharing

      sudo apt install nfs-kernel-server
      sudo nano /etc/exports

      "/path/to the/dir"	10.1.1.0/24(rw,sync,no_subtree_check)

      sudo systemctl restart nfs-kernel-server

      sudo systemctl status nfs-kernel-server

---
# unifi debian install

      sudo apt install gnupg -y
      wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
      echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/4.2 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
      sudo apt-get update
      sudo apt-get install -y mongodb-org
      sudo apt-get update && sudo apt-get install ca-certificates apt-transport-https
      echo 'deb https://www.ui.com/downloads/unifi/debian stable ubiquiti' | sudo tee /etc/apt/sources.list.d/100-ubnt-unifi.list
      sudo wget -O /etc/apt/trusted.gpg.d/unifi-repo.gpg https://dl.ui.com/unifi/unifi-repo.gpg
      sudo apt-get update && sudo apt-get install unifi -y

# create samba file share

      sudo apt install samba
      sudo /etc/samba/smb.conf
            workgroup = WORKGROUP
            interfaces = 192.168.1.0/24 eth0
            hosts allow = 127.0.0.1/8 192.168.1.0/24

# resize partitions 
### LVM [ubuntu]

      # list info 
      pvs
      vgs
      lvs

      # fdisk (new partition, space added via esxi)
      fdisk /dev/sda
      n
      default ? <enter>
      ...
      t   type
      8e  linux filesystem
      w   write

      # pvcreate (create physical volume)
      pvcreate /dev/sdaX
      pvs

      # vgextend (extend volume group)
      vgextend <vg-name> /dev/sdaX
      vgs
      
      # resize logical volume
      lvm <enter>
        lvextend -l +100%FREE /dev/ubuntu-vg/ubuntu-lv
        exit

      # resize filesystem
      resize2fs /dev/ubuntu-vg/ubuntu-lv

# NON-LVM (Debian), standard

      root
      fdisk -l
      fdisk /dev/sda
      p     #take note of start cylinder sda1
      d     #delete all
      d
      d
      n     #new
      p     #primary
      1
      enter
      enter
      n     #no, do not remove signature
      a     #bootable
      w     #write changes

      #sudo reboot unncessary?

      sudo resize2fs /dev/sda1

      sudo nano /etc/fstab
      #comment out swap

      use p to list the partitions. Make note of the start cylinder of /dev/sda1
      use d to delete first the swap partition (2) and then the /dev/sda1 partition. This is very scary but is actually harmless as the data is not written to the disk until you write the changes to the disk.
      use n to create a new primary partition. Make sure its start cylinder is exactly the same as the old /dev/sda1 used to have. For the end cylinder agree with the default choice, which is to make the partition to span the whole disk.
      *** "N" - do not remove signature!
      use a to toggle the bootable flag on the new /dev/sda1
      review your changes, make a deep breath and use w to write the new partition table to disk. You'll get a message telling that the kernel couldn't re-read the partition table because the device is busy, but that's ok.
      sudo reboot
      sudo resize2fs /dev/sda1      The next magic command is resize2fs.  this form will default to making the filesystem to take all available space on the partition.
      sudo nano /etc/fstab
      comment out unused swap partition

-

# file permissions
### **reading permissions**

  - **three** types of permission

      read | write | execute
      ---|--|---
      open | add | run file
      read |remove|...
      ls dir| rename |  ...
      ...| move | ...
 - **three** levels of permission

      - owner of file
      - user group
      - public

 - **example**

        drwxrwxrwx  1 bmilcs   140   69 Mar  5 09:44 dl

      - ***drwxrwxrwx*** = file permissions
      - reads as: **d | rwx | rwx | rwx**

           file or dir | user | group  | public
           :-:|:-:|:-:|:-:
           **[d]** *rwxrwxrwx* | *d* [**rwx**] *rwxrwx* | *d* *rwx* [**rwx**] *rwx* | *d* *rwx* *rwx* [**rwx**]

### **changing ownership**
- **chown** command

  - **1 file/folder:**

        chown username file.zip
        chown UID file.zip

  - **everything in current directory**

        chown username *
        chown UID *

  - **everything: current directory & subdirectories** (recursive)

        chown -R username *
        chown -R UID *

### changing permissions
- **chmod** command

      chmod permissions filename    # single file/dir
      chmod permissions *           # everything (current dir)
      chmod -R permissions *        # everything (current dir & subdir)

  - chmod requires **3 permissions**

        chmod 764 file.zip

  - chmod permission arguments

      chmod | rule | ie.
      ---:|:---:|:--
      0	|None	|---
      1	|Execute	|--x
      2	|Write	|-w-
      3	|Write Execute	|-wx
      4	|Read|r--
      5	|Read Execute	|r-x
      6	|Read Write	|rw-
      7	|Read Write Execute |rwx

      results in: **-rwxrw-r--**

      7 | 6 | 4
      :--:|:--:|:--:
      owner   |  group |    all
      rwx | rw- | r--
      read write execute|read write|read

## owner & user groups

### reading user (owner) & user groups
- **ls** command

     - **list user & user group**

            $ ls -lia

            648799826320195755 drwxrwxrwx  1 bmilcs bmgrp   69 Mar  7 15:33 dl
                        284018 drwxr-xr-x 19 bmilcs bmgrp 4096 Mar  7 15:09 docker
                        264505 drwxr-xr-x  9 bmilcs bmgrp 4096 Mar  5 11:49 media

       - **bmilcs** is user (left)
       - **bmgrp** is group (right)

     - **list puid & pguid**

            $ ls -lian        # -n argument
            648799826320195755 drwxrwxrwx  1 1086 1000   69 Mar  7 15:33 dl
                        284018 drwxr-xr-x 19 1086 1000 4096 Mar  7 15:09 docker
                        264505 drwxr-xr-x  9 1086 1000 4096 Mar  5 11:49 media

        - **1086** is user's id (left)
        - **1000** is user group's id (right)

### change user's PGUID / PUID

- **usermod -u** command changes a user's PUID/PID

      usermod -u #PID# bmilcs

- **groupmod -g** command changes user's PGUID/GID

      groupmod -g #GID# bmilcs    #group

   - verify file changes

            ls -l
            ls -ln

### applying new PGUID/PUID to files & directories**

- **/home/user** contents are automatically changed with user/groupmod commands

- **other locations** require manual permission commands

    - substitute **$OLD-GID** with **OLD group id**
    - substitute **$OLD-PID** with **OLD used user id**

          find / -group $OLD-GID -exec chgrp -h bmilcs {} \;
          find / -user $OLD-UID -exec chown -h bmilcs {} \;

    - **verify everything**

          ls -l /home/bmilcs/
          id -u bmilcs
          id -g bmilcs
          grep bmilcs /etc/passwd
          grep bmilcs /etc/group
          find / -user bmilcs -ls
          find / -group sales -ls
<br>
---
<br>
---

# linux OS setup

      **** ROOT ****
      apt update && apt upgrade
      apt install sudo

##### custom ssh login script
      # remove bs from ssh login
      touch /home/bmilcs/.hushlogin

      # add banner location to sshd_config
      if grep -Fxq "#Banner none" /etc/ssh/sshd_config
      then
            echo '> enabled banner option > /etc/banner'
            sed -i '/#Banner/c\Banner /etc/banner' /etc/ssh/sshd_config
      else
            echo '> error: sshd_config already configured.'
      fi

      # import custom banner text
      touch /etc/banner
      echo > /etc/banner
      printf "%s" "-----------------------------------------------------" >> /etc/banner
      printf "\n%s" "  >>>   bmilcs homelab" "   >>   host:   " >> /etc/banner
      echo $HOSTNAME >> /etc/banner
      ipp="ip a | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'"
      eval ip=\$\($ipp\)
      printf "%s" "    >   ip:     " >> /etc/banner
      echo $ip >> /etc/banner
      printf "%s\n\n" "-----------------------------------------------------" >> /etc/banner
      sudo /etc/init.d/ssh restart

#### 2. configure network ####

      sudo vi /etc/network/interfaces

#### /etc/network/interfaces

      auto lo
      iface lo inet loopback

      auto enp2s0
      iface enp2s0 inet static      ### static ip
      iface eth0 inet dhcp          ### or dhcp
            address 10.1.99.2
            netmask 255.255.255.0
            gateway 10.1.99.254
            dns nameservers 209.222.18.222      ### pia
            dns nameservers 209.222.18.218      ### pia 2
            up route add -net 10.1.1.0 netmask 255.255.255.0 gw 10.1.99.254   ### allow lan access

### sudo user

      usermod -aG sudo bmilcs

### sudo without password

      sudo vi /etc/sudoers
      bmilcs    ALL=NOPASSWD: ALL

### universal ssh: rsa
	**** ROOT ****
	sudo mkdir ~/.ssh
	sudo chmod 0700 ~/.ssh
	sudo touch ~/.ssh/authorized_keys
	sudo chmod 0644 ~/.ssh/authorized_keys
	sudo vi ~/.ssh/authorized_keys
			ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAngRc7vefUjzk2k6noOtBlhAzROXTAxG31mwuMXF2/qM8O795WMBHdPndW/5M7Zxk06waqPDDfsjRNj/Zmhfq62kFdTeUP+4WZlo6SZ6v3xVthhf+WQjEDejsVkRoilZIyyA3dxzbLJZzK0RE/sJ8kbIZ1yb+a8sAI6OSUWvIhhfKyfIilNbATuctXKnZRaQVPKHbsCWhS/BYgpVRJmm6TCtjmEnUZGl1+liio4hvlgaXxsZH5Mi2/+1BcKj/5+OQqq8gM2SNDO/vnfRJLTE9yUrvtvUJUJ6XLWnHVigIjZJK/prdzY/N7dHuUVKVV3NsbdhNgzb4N8hsdzRsiGp7Pw== bmilcs

	sudo vi /etc/ssh/sshd_config
			PermitRootLogin yes
			PubkeyAuthentication yes
			AuthorizedKeysFile %h/.ssh/authorized_keys
	sudo service ssh restart
	OR...
	/etc/rc.d/rc.sshd restart

---

# unraid

## ssh: rsa
	cd /boot/config/ssh/
	sudo vi authorized_keys
			ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAngRc7vefUjzk2k6noOtBlhAzROXTAxG31mwuMXF2/qM8O795WMBHdPndW/5M7Zxk06waqPDDfsjRNj/Zmhfq62kFdTeUP+4WZlo6SZ6v3xVthhf+WQjEDejsVkRoilZIyyA3dxzbLJZzK0RE/sJ8kbIZ1yb+a8sAI6OSUWvIhhfKyfIilNbATuctXKnZRaQVPKHbsCWhS/BYgpVRJmm6TCtjmEnUZGl1+liio4hvlgaXxsZH5Mi2/+1BcKj/5+OQqq8gM2SNDO/vnfRJLTE9yUrvtvUJUJ6XLWnHVigIjZJK/prdzY/N7dHuUVKVV3NsbdhNgzb4N8hsdzRsiGp7Pw== rsa-NAMEHERE
	sudo vi /boot/config/go
			mkdir /root/.ssh
			chmod 700 /root/.ssh
			cp /boot/config/ssh/authorized_keys /root/.ssh/
			chmod 600 /root/.ssh/authorized_keys

## mount share

### vm gui

      <filesystem type='mount' accessmode='passthrough'>
      <source dir='/mnt/user/storage/downloads/vm'/>
      <target dir='share'/>
      </filesystem>
      <filesystem type='mount' accessmode='passthrough'>
      <source dir='/mnt/user/storage/downloads/#torrent/watch'/>
      <target dir='watch'/>
      </filesystem>

### within vm

	sudo mkdir /home/share
	sudo vi /etc/fstab
	share /home/#share       9p      trans=virtio,version=9p2000.L,_netdev,rw        0 0
	share /home/#watch       9p      trans=virtio,version=9p2000.L,_netdev,rw        0 0

---
# unattended upgrades

      apt-get install unattended-upgrades apt-listchanges

      sudo vi /etc/apt/apt.conf.d/20auto-upgrades
            APT::Periodic::Update-Package-Lists "1";
            APT::Periodic::Unattended-Upgrade "1";
            APT::Periodic::Download-Upgradeable-Packages "1";
            APT::Periodic::AutocleanInterval "7";
            APT::Periodic::Verbose "1";

      sudo vi /etc/apt/apt.conf.d/50unattended-upgrades
            "${distro_id}:${distro_codename}-updates";
            Unattended-Upgrade::Mail "bmilcs@yahoo.com";
            Unattended-Upgrade::Remove-Unused-Dependencies "true";
            Unattended-Upgrade::Automatic-Reboot "true";
            Unattended-Upgrade::Automatic-Reboot-Time "02:00";

## FIND ALTERNATIVE TO MAILX

# unattended upgrades *rpi*

        "o=${distro_id},n=${distro_codename}";
        "o=${distro_id},n=${distro_codename}-updates";
        "o=${distro_id},n=${distro_codename}-proposed-updates";
        "o=${distro_id},n=${distro_codename},l=Debian-Security";

# test config

      sudo unattended-upgrades --dry-run --debug

---

# openvpn
      openvpn –config client.ovpn

---
# xrdp

### xrdp.ini

      sudo vi etc/xrdp/xrdp.ini

#### cleanup

      # comment the following:

      #[Xorg]
      #[vnc-any]
      #[sesman-any]
      #[rdp-any]
      #[neutrinordp-any]

### add lan for access

      sudo route add -net 10.1.1.0/24 gw 10.1.99.254

### list installed apts

	apt list --installed | grep vnc

### restart network

	/etc/init.d/networking restart

### debian fix

	sudo vi /run/systemd/resolve/resolv.conf
		search bm.bmilcs.com
		nameservers 1.1.1.1
			10.1.99.254
	gsettings set org.gnome.desktop.interface enable-animations false
	xrdp
	max_bpp 128

# clean up | optimize | misc useful commands

### del apps via string

	sudo apt-get remove libreoffice.*

## debugging

### check linux crash logs

	sudo vi /var/crash

---
## misc

replace whole line found in file
      sed -i '/TEXT_TO_BE_REPLACED/c\This line is removed by the admin.' /tmp/foo

---

## apt-get basics

#### always UPDATE before apt upgrade / dist-upgraded

#### update

	apt-get update
		updates package lists
	apt-get upgrade
		downloads latest versions of installed packages (via apt-get update list)
		* "from the sources enumerated in /etc/apt/sources.list(5)"
	apt-get dist-upgrade
		performs "apt-get upgrade" AND intelligently handles the dependencies
		MAY remove obsolete packages or add new ones
	      > /etc/apt/sources.list(5) = list of locations for package files
		> apt_preferences(5) - overriding the general settings for individual packages.

#### maintenance
      apt-get -f install
            "Fix Broken Packages"
      apt-get autoclean
            removes .deb files no longer installed on system.
      *apt-get autoremove
            removes packages that were installed by other packages and are no longer needed.

#### delete
      apt-get remove X
            removes package
            leaves configuration files intact
      apt-get purge X
            removes package
            removes all config files
      apt-get autoremove X
            deletes package & dependencies

---
# vpn dns

      sudo nano /etc/resolv.conf
      209.222.18.222
      209.222.18.218

# vpn killswitch (current)

      #!/bin/bash
      iptables -F
      iptables -X
      iptables -t nat -F
      iptables -t nat -X
      ip6tables -F
      ip6tables -X
      ip6tables -t nat -F
      ip6tables -t nat -X

      # localhost > accept all
      iptables -A INPUT -i lo -j ACCEPT
      iptables -A OUTPUT -o lo -j ACCEPT
      ip6tables -A INPUT -i lo -j ACCEPT
      ip6tables -A OUTPUT -o lo -j ACCEPT

      # allow ping
      iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT

      # lan > accept all
      iptables -A INPUT  -i enp2s0 -s 10.1.1.0/24 -j ACCEPT
      iptables -A OUTPUT -o enp2s0 -d 10.1.1.0/24 -j ACCEPT
      iptables -A INPUT  -i enp2s0 -s 10.1.2.0/24 -j ACCEPT
      iptables -A OUTPUT -o enp2s0 -d 10.1.2.0/24 -j ACCEPT
      iptables -A INPUT  -i enp2s0 -s 10.1.86.0/24 -j ACCEPT
      iptables -A OUTPUT -o enp2s0 -d 10.1.86.0/24 -j ACCEPT
      iptables -A INPUT  -i enp2s0 -s 10.1.99.0/24 -j ACCEPT
      iptables -A OUTPUT -o enp2s0 -d 10.1.99.0/24 -j ACCEPT

      # allow dns
      iptables -A INPUT  -p udp --sport 53 -j ACCEPT
      iptables -A OUTPUT -p udp --dport 53 -j ACCEPT

      # allow vpn traffic
      iptables -A INPUT  -p udp --sport 1194 -j ACCEPT
      iptables -A OUTPUT -p udp --dport 1194 -j ACCEPT
      iptables -A INPUT  -p udp --sport 1198 -j ACCEPT
      iptables -A OUTPUT -p udp --dport 1198 -j ACCEPT

      # xrdp ports
      ip6tables -I INPUT -p tcp --dport 3350 -m state --state NEW,ESTABLISHED -j ACCEPT
      ip6tables -I INPUT -p udp --dport 3389 -m state --state NEW,ESTABLISHED -j ACCEPT
      ip6tables -I INPUT -p tcp --dport 3389 -m state --state NEW,ESTABLISHED -j ACCEPT
      ip6tables -I INPUT -p tcp --dport 5910 -m state --state NEW,ESTABLISHED -j ACCEPT

      # dns: pia
      iptables -A INPUT  -d 209.222.18.222 -j ACCEPT
      iptables -A OUTPUT -d 209.222.18.222 -j ACCEPT
      iptables -A OUTPUT -d 209.222.18.218 -j ACCEPT
      iptables -A OUTPUT -d 209.222.18.218 -j ACCEPT

      # PIA server
      iptables -A INPUT  -p udp -s swiss.privateinternetaccess.comm -j ACCEPT;
      iptables -A OUTPUT -p udp -d swiss.privateinternetaccess.com -j ACCEPT;

      # Accept TUN
      iptables -A INPUT    -i tun+ -j ACCEPT
      iptables -A OUTPUT   -o tun+ -j ACCEPT
      iptables -A FORWARD  -i tun+ -j ACCEPT

      # Drop the rest
      iptables -A INPUT   -j DROP
      iptables -A OUTPUT  -j DROP
      iptables -A FORWARD -j DROP
      ip6tables -A INPUT   -j DROP
      ip6tables -A OUTPUT  -j DROP
      ip6tables -A FORWARD -j DROP

---

# **common fixes | errors**

- #### can't open lock file /var/lib/dpkg/lock-frontend (permission denied)

  ![error](https://i.imgur.com/5Om2naZ.png)

      sudo killall apt apt-get
      sudo rm /var/lib/apt/lists/lock
      sudo rm /var/cache/apt/archives/lock
      sudo rm /var/lib/dpkg/lock*
      sudo dpkg --configure -a
      sudo apt update


todo:
- [ ] varken

