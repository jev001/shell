#!/bin/bash
#Program
#1. 删除本地代码文件
#2. clone gitlab代码
#3. 移动除.git/文件夹之外的到svn的文件中 

# read -p "请输入项目名字:" projectName
# read -p "请输入svn的绝对路径:" svn_dir
# svn_dir="E:\Sources\bigdata\trunk"
echo remote名称为$remote_name
echo remote地址为$remote_base_url
echo 应用为$1

if [ ! -n "$remote_base_url" ]; then
	echo "未输入拼接提交地址"
	exit
fi

if [ ! -n "$1" ]; then
	echo "未输入应用名"
	exit
fi

projectName=$1
# 怕删错svn，于是做一个判断，是否是想要的svn地址 

basepath=$(cd `dirname $0`; pwd)

projectPath=$basepath/$projectName
cd $projectName
remote_url=$remote_base_url$projectName
gitee_remote=`git remote add $remote_name $remote_url`
echo "output: "$gitee_remote
echo "new remote:$remote_name url "$remote_url
# 结束后，回到原本的目录，方便下次执行
cd $basePath
