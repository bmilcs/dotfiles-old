# Read Permission

  head -1 /path/to/file 2>&1 > /dev/null | grep 'Permission denied'
  
  if [ $? -eq 0 ]; then
      echo OK
  else
      echo FAIL
  fi

# Write Permission

touch -c /path/to/file 2>&1 | grep 'Permission denied'

# Specify User:

