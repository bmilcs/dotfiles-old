teee() {
  local file=$1 ERRNO=0 LC_ALL=C
  if [ -d "$file" ]; then
    return 1 # directory
  elif [ -w "$file" ]; then
    return 0 # writable non-directory
  elif [ -e "$file" ]; then
    return 1 # exists, non-writable
  elif [ "$errnos[ERRNO]" != ENOENT ]; then
    return 1 # only ENOENT error can be recovered
  else
    local dir=$file:P:h base=$file:t
    echo $dir
    echo $file
#    [ -d "$dir" ] &&    # directory
#      [ -w "$dir" ] &&  # writable
#      [ -x "$dir" ] &&  # and searchable
#      (($#base <= $(getconf -- NAME_MAX "$dir")))
    return
  fi
}
