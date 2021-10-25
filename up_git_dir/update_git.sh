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

if [ ! -n "$1" ]; then
	echo "未输入需要更新分支"
	exit
fi

checkout_back="true"
if [ -n "$2" ]; then
	checkout_back="false"
    echo "checkout_back disable"
fi

dst_branch=$1
# 怕删错svn，于是做一个判断，是否是想要的svn地址 

basepath=$(cd `dirname $0`; pwd)

projectPath=$basepath/$projectName
echo "change dst dir:"$projectPath
cd $projectPath

origin_branch=`git branch |head -n 1|awk '{print $2}'`
echo 'current branch:'$origin_branch

git_checkout_dst="git checkout "$dst_branch
echo "checkout dst command:"$git_checkout_dst
$git_checkout_dst

git_pull_dst="git pull"
echo "pull dst command:"$git_pull_dst
$git_pull_dst

if [ $checkout_back=="true" ]; then
    git_checkout_ori="git checkout "$origin_branch
    echo "checkout ori command:"$git_checkout_ori
    $git_checkout_ori
fi

# 结束后，回到原本的目录，方便下次执行
echo "change ori dir:"$basePath
cd $basePath
