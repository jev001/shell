#!/bin/bash
#Program
#遍历当前目录，将目录下所有应用挪至svn目录

command=$1


export remote_name=$remote_name

export remote_base_url=$remote_base_url
appList=`ls -d */ |awk -F / '{print $1}'`

function add_remote() {
   read -p "请输入remote名称为:" remote_name
   read -p "请输入remote地址为:" remote_base_url
   for appFile in $appList
   do
      if [ $appFile != git_batch_add_remote.sh -a $appFile != git_batch_this_dir.sh ]; then

      ./git_batch_add_remote.sh $appFile
      fi
   done
}



function push_remote() {

   read -p "请输入remote名称为:" remote_name
   for appFile in $appList
   do
      if [ $appFile != git_batch_push_remote.sh -a $appFile != git_batch_this_dir.sh ]; then

      ./git_batch_push_remote.sh $appFile
      fi
   done
}


usage="Usage: `basename $0` (add|push) parameter1 parameter2"

case $command in
  (add)
     add_remote
     ;;
  (push)
     push_remote
     ;;
  (*)
     echo "Error command"
     echo "$usage"
     ;;
esac


