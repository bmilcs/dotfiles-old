# Sed Cheat Sheet

## personal examples
``` bash



```




## Sed command line options

```
sed [options] sed-command [input-file]
```

| Option | Description                             | Example                                      |
| ------ |---------------------------------------- | -------------------------------------------- |
| `-n`   | Suppress default pattern space printing | `sed -n '3 p' config.conf`                   |
| `-i`   | Backup and modify input file directly   | `sed -ibak 's/On/Off/' php.ini`              |
| `-f`   | Execute sed script file                 | `sed -f script.sed config.conf`              |
| `-e`   | Execute multiple sed commands           | `sed -e 'command1' -e 'command2' input-file` |

## Sed commands

| Command | Description                  | Example                                   |
| ------- |----------------------------- | ----------------------------------------- |
| `p`     | Print pattern space          | `sed -n '1,4 p' input.txt`                |
| `d`     | Delete lines                 | `sed -n '1,4 d' input.txt`                |
| `w`     | Write pattern space to file  | `sed -n '1,4 w output.txt' input.txt`     |
| `a`     | Append line after            | `sed '2 a new-line' input.txt`            |
| `a`     | Insert line before           | `sed '2 i new-line' input.txt`            |

## Sed substitute command and flags

```
 sed 's/original-string/replacement-string/[flags]' [input-file]
 ```
 
| Flag             | Description                                 | Example                                                |
| ---------------- |-------------------------------------------- | ------------------------------------------------------ |
| `g`              | Global substitution                         | `sed 's/development/production/g' .env`                |
| `1,2...`         | Substitute the nth occurrence               | `sed 's/latin1/utf8/2' locale.sql`                     |
| `p`              | Print only the substituted line             | `sed -n 's/error_log = 0/error_log = 1/p' php.ini`     |
| `w`              | Write only the substituted line to a file   | `sed -n 's/One/Two/w output.txt' words.txt`            |
| `i`              | Ignore case while searching                 | `sed 's/true/FALSE/i' config.php`                      |
| `e`              | Substitute and execute in the command line  | `sed 's/^/ls -l /e' files.list`                        |
| `/ | ^ @ !`      | Substitution delimiter can be any character | `sed 's|/usr/local/bin|/usr/bin|' paths.list`          |
| `&`              | Gets the matched pattern                    | `sed 's/^.*/<&>/' index.xml`                           |
| `( ) \1 \2 \3` | Group using `(` and `)`.<br>Use `\1`, `\2` in replacement to refer the group | `sed 's/([^,]*),([^,]*),([^,]*).*/\1,\3/g' words.txt` |

Read more about escaping:

* http://unix.stackexchange.com/questions/32907/what-characters-do-i-need-to-escape-when-using-sed-in-a-sh-script

## Loops and multi-line sed commands

| Command    | Description                                                        | Example                                         |
| ---------- |------------------------------------------------------------------- | ----------------------------------------------- |
| `b lablel` | Branch to a label (for looping)                                    |                                                 |
| `t lablel` | Branch to a label only on successful substitution<br>(for looping) |                                                 |
| `:lablel`  | Label for the b and t commands (for looping)                       |                                                 |
| `N`        | Append next line to pattern space                                  | `sed = file.txt | sed "N;s/\n/$(printf '\t')/"` |
| `P`        | Print 1st line in multi-line                                       |                                                 |
| `D`        | Delete 1st line in multi-line                                      |                                                 |

## Sed hold and pattern space commands

| Command | Description                                                  |
| ------- |------------------------------------------------------------- |
| `n`     | Print pattern space, empty pattern space, and read next line |
| `x`     | Swap pattern space with hold space                           |
| `h`     | Copy pattern space to hold space                             |
| `H`     | Append pattern space to hold space                           |
| `g`     | Copy hold space to pattern space                             |
| `G`     | Append hold space to pattern space                           |
