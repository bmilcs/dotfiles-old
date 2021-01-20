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

# LINUX OPERATORS 

## A. Control operators
[POSIX definition](https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap03.html#tag_03_113)

> In the shell command language, a token that performs a control function.  
> It is one of the following symbols:

>     &   &&   (   )   ;   ;;   <newline>   |   ||

And `|&` in bash.

A `!` is **not** a control operator but a [Reserved Word](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_04). It becomes a logical NOT [negation operator] inside [Arithmetic Expressions](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap01.html#tag_17_01_02) and inside test constructs (while still requiring an space delimiter).

### A.1 List terminators

* `;` : Will run one command after another has finished, irrespective of the outcome of the first.

        command1 ; command2

 First `command1` is run, in the foreground, and once it has finished, `command2` will be run.

 A newline that isn't in a string literal or after certain keywords is *not* equivalent to the semicolon operator. A list of `;` delimited simple commands is still a *list* - as in the shell's parser must still continue to read in the simple commands that follow a `;` delimited simple command before executing, whereas a newline can delimit an entire command list - or list of lists. The difference is subtle, but complicated: given the shell has no previous imperative for reading in data following a newline, the newline marks a point where the shell can begin to evaluate the simple commands it has already read in, whereas a `;` semi-colon does not.

* `&` : This will run a command in the background, allowing you to continue working in the same shell.
 
         command1 & command2
     
 Here, `command1` is launched in the background and `command2` starts running in the foreground immediately, without waiting for `command1` to exit.

 A newline after `command1` is optional.

### A.2 Logical operators

* `&&` : Used to build AND lists, it allows you to run one command only if another exited successfully.
 
         command1 && command2
     
 Here, `command2` will run after `command1` has finished and _only_ if `command1` was successful (if its exit code was 0). Both commands are run in the foreground.

 This command can also be written

        if command1
        then command2
        else false
        fi

 or simply `if command1; then command2; fi` if the return status is ignored.
 
* `||` : Used to build OR lists, it allows you to run one command only if another exited unsuccessfully.
 
         command1 || command2
     
 Here, `command2` will only run if `command1` failed (if it returned an exit status other than 0). Both commands are run in the foreground.

 This command can also be written

        if command1
        then true
        else command2
        fi

 or in a shorter way `if ! command1; then command2; fi`.

 Note that `&&` and `||` are left-associative; see https://unix.stackexchange.com/questions/88850/precedence-of-the-shell-logical-operators for more information.

* `!`: This is a reserved word which acts as the “not” operator (but must have a delimiter), used to negate the return status of a command — return 0 if the command returns a nonzero status, return 1 if it returns the status 0. Also a logical NOT for the `test` utility.

        ! command1

        [ ! a = a ]

 And a true NOT operator inside Arithmetic Expressions:

        $ echo $((!0)) $((!23))
        1 0

### A.3 Pipe operator
 
* `|` : The pipe operator, it passes the output of one command as input to another. A command built from the pipe operator is called a [pipeline](http://en.wikipedia.org/wiki/Pipeline_(Unix)).
 
         command1 | command2
     
  Any output printed by `command1` is passed as input to `command2`. 
  
* `|&` : This is a shorthand for `2>&1 |` in bash and zsh. It passes both standard output and standard error of one command as input to another.

        command1 |& command2

### A.4 Other list punctuation

`;;` is used solely to mark the end of a [case statement](https://www.gnu.org/software/bash/manual/bashref.html#Conditional-Constructs). Ksh, bash and zsh also support `;&` to fall through to the next case and `;;&` (not in ATT ksh) to go on and test subsequent cases.

`(` and `)` are used to [group commands](https://www.gnu.org/software/bash/manual/bashref.html#Command-Grouping) and launch them in a subshell. `{` and `}` also group commands, but do not launch them in a subshell. See [this answer](https://stackoverflow.com/questions/6270440/simple-logical-operators-in-bash/6270803#6270803) for a discussion of the various types of parentheses, brackets and braces in shell syntax.


## B. Redirection Operators

[POSIX definition of Redirection Operator](https://pubs.opengroup.org/onlinepubs/9699919799.2016edition/basedefs/V1_chap03.html#tag_03_318)

> In the shell command language, a token that performs a redirection function. It is one of the following symbols:

>     <     >     >|     <<     >>     <&     >&     <<-     <>



These allow you to control the input and output of your commands. They can appear anywhere within a simple command or may follow a command. Redirections are processed in the order they appear, from left to right. 

* `<` : Gives input to a command.
 
        command < file.txt
     
 The above will execute `command` on the contents of `file.txt`.

* `<>` : same as above, but the file is open in _read+write_ mode instead of _read-only_:

        command <> file.txt

 If the file doesn't exist, it will be created.

 That operator is rarely used because commands generally only _read_ from their stdin, though [it can come handy in a number of specific situations](https://unix.stackexchange.com/a/164449).

* `>` : Directs the output of a command into a file.

        command > out.txt
    
 The above will save the output of `command` as `out.txt`. If the file exists, its contents will be overwritten and if it does not exist it will be created.  
 
 This operator is also often used to choose whether something should be printed to [standard error](http://en.wikipedia.org/wiki/Standard_streams#Standard_error_.28stderr.29) or [standard output](http://en.wikipedia.org/wiki/Standard_streams#Standard_output_.28stdout.29):
 
        command >out.txt 2>error.txt
     
 In the example above, `>` will redirect standard output and `2>` redirects standard error. Output can also be redirected using `1>` but, since this is the default, the `1` is usually omitted and it's written simply as `>`.

 So, to run `command` on `file.txt` and save its output in `out.txt` and any error messages in `error.txt` you would run:
     
        command < file.txt > out.txt 2> error.txt
      
* `>|` : Does the same as `>`, but will overwrite the target, even if the shell has been configured to refuse overwriting (with `set -C` or `set -o noclobber`).
         
        command >| out.txt
     
 If `out.txt` exists, the output of `command` will replace its content. If it does not exist it will be created.  

* `>>` : Does the same as `>`, except that if the target file exists, the new data are appended.
         
        command >> out.txt
     
 If `out.txt` exists, the output of `command` will be appended to it, after whatever is already in it. If it does not exist it will be created.  

* `>&` : (per POSIX spec) when surrounded by **digits** (`1>&2`) or `-` on the right side (`1>&-`) either redirects only **one** file descriptor or closes it (`>&-`).

 A `>&` followed by a file descriptor number is a portable way to redirect a file descriptor, and `>&-` is a portable way to close a file descriptor.

 If the right side of this redirection is a file please read the next entry.

* `>&`, `&>`, `>>&` and `&>>` : (read above also) Redirect both standard error and standard output, replacing or appending, respectively.

        command &> out.txt
   
 Both standard error and standard output of `command` will be saved in `out.txt`, overwriting its contents or creating it if it doesn't exist.
 
        command &>> out.txt
     
 As above, except that if `out.txt` exists, the output and error of `command` will be appended to it.

 The `&>` variant originates in `bash`, while the `>&` variant comes from csh (decades earlier). They both conflict with other POSIX shell operators and should not be used in portable `sh` scripts.
 
* `<<` : A here document. It is often used to print multi-line strings.
 
         command << WORD
             Text
         WORD
         
  Here, `command` will take everything until it finds the next occurrence of `WORD`, `Text` in the example above, as input .  While `WORD` is often `EoF` or variations thereof, it can be any alphanumeric (and not only) string you like. When `WORD` is quoted, the text in the here document is treated literally and no expansions are performed (on variables for example). If it is unquoted, variables will be expanded. For more details, see the [bash manual](https://www.gnu.org/software/bash/manual/bashref.html#Here-Documents).

  If you want to pipe the output of `command << WORD ... WORD` directly into another command or commands, you have to put the pipe on the same line as `<< WORD`, you can't put it after the terminating WORD or on the line following.  For example:

         command << WORD | command2 | command3...
             Text
         WORD


  
* `<<<` : Here strings, similar to here documents, but intended for a single line. These exist only in the Unix port or rc (where it originated), zsh, some implementations of ksh, yash and bash.

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

----


      # zstyle ':completion:*:stw:*' file-patterns '*(/):directories'

      # lists everything
      compdef '_files -g "$HOME/bm/*"' stw

#### REFERENCES
- [**Linuxize: Bash Functions**](https://linuxize.com/post/bash-functions/)
- [**Stackoverflow: Autocomplete @ specific dir**](https://stackoverflow.com/questions/57426500/list-directories-at-a-specific-path-as-autocomplete-options-for-a-bash-script)



