#!/bin/bash
git_repos=`find . -maxdepth 1 -type d`
current_dir=`pwd`
for var in $git_repos; do
  if [ "$var" = "." ]; then
    continue
  fi
  if [ "$var" = "./.idea" ]; then
    continue
  fi
  cd $var
  echo "current_dir = "`pwd`
  echo git status
  git status
  echo git switch master
  git switch master
  echo git pull -f
  git pull -f
  echo "back return parent_dir="$current_dir
  cd $current_dir
done;