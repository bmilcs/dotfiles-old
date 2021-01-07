## BMILCS FUNCTION NOTES

#### ARGUMENT HANDLING

var | desc
-|:-
$#    |   number of command-line arguments that were passed to the shell program.
$?    |   exit value of the last command that was executed.
$0    |   first word of the entered command (the name of the shell program)
$*    |   all arguments command line ($1 $2 ...).
"$@"  |   all arguments command line, individually quoted ("$1" "$2" ...).

#### REFERENCES
- [**Linuxize: Bash Functions**](https://linuxize.com/post/bash-functions/)
