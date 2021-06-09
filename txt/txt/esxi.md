# esxi

### freenas integration
``` bash
# utility-scripts-for-freenas-and-vmware-esxi 
# https://github.com/Spearfoot/utility-scripts-for-freenas-and-vmware-esxi




```

### renaming folders & vmdisks

``` bash
#!/bin/sh
# bmilcs: vm renamer script

if [ ! $# == 2 ]; then
        echo "error: invalid # of arguments"
        exit 1
fi

folder="$1"
new="$2"

echo "$folder selected for renaming"
echo "$new for new name"

if [ ! -d "$folder" ]; then
        echo "error not found"
        exit 1
fi

mv "$folder" "$new" || exit 1

cd "$new" || exit 1
len=${#folder}
len=$((len+1))
echo $len

for name in $folder*
do
    newname="$new$(echo "$name" | cut -c${len}-)"
    mv "$name" "$newname"
done


```
