#!/bin/bash
#Program
#遍历当前目录，将目录下所有应用挪至svn目录


read -p "请输入remote名称为:" remote_name
read -p "请输入remote地址为:" remote_base_url

export remote_name=$remote_name

export remote_base_url=$remote_base_url
appList=`ls .`
for appFile in $appList
do
   if [ $appFile != sync_src.sh -a $appFile != sync_this_dir.sh ]; then

	./sync_src.sh $appFile
   fi
done



