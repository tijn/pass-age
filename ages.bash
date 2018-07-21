#!/bin/bash

help_ages() {
  echo "Usage:"
  echo "    pass ages"
  echo "        Show ages of all passwords in the store"
  echo "    pass ages SUBDIR"
  echo "        Show ages of all passwords in a certain subdirectory in the store"
  exit 0
}

if [ "$1" == "--help" ]
then
  help_ages
fi

PREFIX="${PASSWORD_STORE_DIR:-$HOME/.password-store}"
SUBDIR="${1:-.}"

cd $PREFIX && find $SUBDIR -name "*.gpg" | sed 's/^\.\///' | sed 's/\.gpg$//' | while read path
do
  pass age "$path"
done
