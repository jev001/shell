#!/bin/bash
#Program
#遍历当前目录，将目录下所有应用挪至svn目录

command=$1


export remote_name=$remote_name

export remote_base_url=$remote_base_url
appList=`ls -d */ |awk -F / '{print $1}'`

target_branch=$1
back_origin_branch=$2

if [ $target_branch == "" ]; then
    echo "target_branch missing"
    exit
fi


for appFile in $appList
   do
      export projectName=$appFile
      ./update_git.sh $target_branch $back_origin_branch
   done
