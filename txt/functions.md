##### BMILCS FUNCTION NOTES

# ARGUMENT HANDLING

var | desc
-|:-
$#    |   number of command-line arguments that were passed to the shell program.
$?    |   exit value last command executed. (0=success,1+ ???)
$0    |   first word of entered command (the name of the shell program)
$*    |   all arguments command line ($1 $2 ...).
"$@"  |   all arguments command line, individually quoted ("$1" "$2" ...).

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



