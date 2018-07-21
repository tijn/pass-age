#!/bin/bash

# - assume the password is stored in the first line of a password-file
# - find the latest git revision that changes that line
# - show all passwords by age


PREFIX="${PASSWORD_STORE_DIR:-$HOME/.password-store}"
export GIT_DIR="${PASSWORD_STORE_GIT:-$PREFIX}/.git"

git_revisions() {
 [[ -d $GIT_DIR ]] || return
 local path="$1"
 local passfile="$path.gpg"
 git log --format=%H -- $passfile
}

git_revision() {
 [[ -d $GIT_DIR ]] || return
 local path="$1"
 local revision="$2"
 local passfile="$path.gpg"
 git show $revision:$passfile | $GPG -d "${GPG_OPTS[@]}" | head -n 1
}

oldest_password_change() {
 [[ -d $GIT_DIR ]] || die "Error: the password store is not a git repository. Try \"$PROGRAMgit init\"."
 local path="$1"
 check_sneaky_paths "$path"
 git_revisions "$path" | while read revision
 do
   if [ -z "$password" ]; then
     password="$(git_revision $path $revision)"
   else
     if [ password != "$(git_revision $path $revision)" ]; then
       break
     fi
   fi
   echo $revision
 done | tail -n 1
}

help_age() {
  echo "Usage:"
  echo "    pass age PASS-NAME"
}

cmd_age() {
  local path="$1"
  check_sneaky_paths "$path"
  local oldest=$(oldest_password_change "$path")
  git show -s --format="%ct%x09%cr%x09"$path"" "$oldest"
}

case $1 in
  --help) help_age ;;
  "") help_age ;;
  *) cmd_age "$@" ;;
esac
