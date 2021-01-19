#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#────────────────────────────────────────────────────────────
#────────────────────────────────────────────────────────────
# "function" cheatsheet
> bmilcs' cheatsheat on shell scripting, functions, etc.


### ARGUMENTS / PARAMETERS

var | desc
-|:-
$#    |   # of arguments
$?    |   exit status, last command (0=true/success)
$0    |   first word of entered command (the name of the shell program)
$*    |   all arguments command line ($1 $2 ...).
"$@"  |   all arguments command line, individually quoted ("$1" "$2" ...).

---

# IF... ELSE

**SYNTAX**

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


# TEST COMMAND (IF)

**SYNTAX**

    test EXPRESSION
    [ expression ]
    test
    [ ]

### EXPRESSIONS

EXPRESSION | ...
---|---
**(** exp **)** | expression is true
**!** exp | expression is false
e1 **-a** e2 | AND: both true 
e1 **&&** e2 | AND: both true 
e1 **-o** e2 | OR: 1 is true
e1 **&#124;&#124;** e2 | OR: 1 is true

### STRINGS

STRINGS | ...
--|--
**-n** str | string length is NON-zero
**-z** str | string length IS zero
s1 **=** s2 | strings are equal, pattern matching
[[ s1 **=** "s2" ]] | strings are equal, literal, NO pattern matching
s1 **!=** s2 | strings NOT are equal
c > a | true: c comes after a (greater value)
c < a | false: a comes before c (less than)
[[ $NAME = derp* ]] | wildcard matching


### INTEGERS
INTEGERS | ...
--|--
x **-eq** y | integers equal
x **-ge** y | greater/equal: i1 >= i2
x **-gt** y | greater: i1 > i2
x **-le** y | lesser/equal: i1 <= i2
x **-lt** y | lesser: i1 < i2
x **-ne** y | NOT equal to: i1 != i2

### FILES/DIRS
FILES | DEF | IE
--:|:--|:--
**-f** | True: is a regular File. | [[ -f demofile ]]
**-d** | True: is a Directory. | [[ -d demofile ]]
**-e** | True: file/dir exists. | [[ -e demofile ]]
**-h** | True: is a symbolic Link. | [[ -h demofile ]]
**-L** | True: is a symbolic Link. | [[ -L demofile ]]
**-G** | True: owned by group id. | [[ -G demofile ]]
**-O** | True: owned by user id. | [[ -O demofile ]]
**-r** | True: is readable. | [[ -r demofile ]]
**-w** | True: is writable. | [[ -w demofile ]]
**-x** | True: is executable. | [[ -x demofile ]]
x **-nt** y | True x is newer than y. | [[ demofile1 -nt $DEMO ]]
x **-ot** y | True x is older than y. | [[ $DEMO -ot demofile2 ]]

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

# INPUT OUTPUT REDIRECTS

[**source**](https://gist.github.com/bmilcs/a51512131d44077a6ee2db818ccb6dca)

example | def
--:|---
1 &#124; 2  |  use stdout of cmd1 as stdin for cmd2
> file  |  save stdout to file
   < file  |  use file as stdin
  >> file  |  append stdout to file (create file if nonexistent)
  >&#124; file  |  force stdout to file (even if noclobber is set)
 n>&#124; file  |  force stdout to file from descriptor n (even...)
  <> file  |  use file as both stdin and stdout (process in place)
 n<> file  |  use as both stdin and stdout for file descriptor n
  << label |  use here-document (within scripts specifies batch input)
  n> file  |  direct file descriptor n to file
  n< file  |  take file descriptor n from file
 n>> file  |  append descriptor n to file (or create file for n)
 n>&       |  duplicate stdout to file descriptor n
 n<&       |  duplicate stdin from file descriptor n
 n>&m      |  make file descriptor n a copy of the stdout fd
 n<&m      |  make file descriptor n a copy of the stdin  fd 
  >&file   |  send stdout and stderror to file
 <&-       |  close stdin
 >&-       |  close stdout
n<&-       |  close input  from file descriptor n
n>&-       |  close output from file descriptor n


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

----


      # zstyle ':completion:*:stw:*' file-patterns '*(/):directories'

      # lists everything
      compdef '_files -g "$HOME/bm/*"' stw

#### REFERENCES
- [**Linuxize: Bash Functions**](https://linuxize.com/post/bash-functions/)
- [**Stackoverflow: Autocomplete @ specific dir**](https://stackoverflow.com/questions/57426500/list-directories-at-a-specific-path-as-autocomplete-options-for-a-bash-script)



