## rsync

### cp/sync: preserve perms, ownership, etc.

``` bash
rsync -zahvP
      # -z  COMPRESSES data via send, reducing amount sent
      # -a  ARCHIVE:
      #     -r  (r)ecursive
      #     -l  retain sym(l)inks
      #     -p  retain (p)ermissions
      #     -t  retain (t)imes, modification, etc.
      #     -g  retain (g)roup (group id)
      #     -o  retain (o)wner (user id)
      #     -D  retain (D)evices
      # -h  HUMAN-readable
      # -v  VERBOSE
      # -P  --progress: shows progress
      #     --partial: allows resuming of aborted syncs
```

### cp/sync: normal, without preservation

``` bash
rsync -zrvh --progress
      # -z  compresses data via send, reducing amount sent
      # -r  recursive
      # -h  human-readable
      # -v  verbose
```

### copy directory structure!!!

``` bash
rsync -av -f"+ */" -f"- *"
      # -v  verbose
      # -a  ARCHIVE:
      #     -r  (r)ecursive
      #     -l  retain sym(l)inks
      #     -p  retain (p)ermissions
      #     -t  retain (t)imes, modification, etc.
      #     -g  retain (g)roup (group id)
      #     -o  retain (o)wner (user id)
      #     -D  retain (D)evices
```

### dry run | move files & delete source

``` bash
rsync -n --remove-source-files
      # -n  dry-run
      # --remove-source-files: MV not CP

```
