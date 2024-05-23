#!/bin/bash
#Program

#!/bin/bash

# 定义默认值
find_path="."
depth=""

# 使用 getopts 处理参数
while getopts ":i:o:rp:" opt; do
  case $opt in
    p) find_path="$OPTARG";;
    d) depth="$OPTARG";;
    \?) echo "Invalid option -$OPTARG" >&2; exit 1;;
  esac
done

allfiles=""
# 检查必需参数是否已设置
if [ -z "$depth" ] ; then
  echo "allfiles=\`find .  -type f -print0 | xargs -0 md5sum | sort\`"
  allfiles=`find .  -type f -print0 | xargs -0 md5sum | sort`
else
  echo "allfiles=\`find . maxdepth \$depth -type f -print0 | xargs -0 md5sum | sort\`"
  allfiles=`find . maxdepth $depth -type f -print0 | xargs -0 md5sum | sort`
fi
echo "uniqfiles=\`echo \$allfiles | uniq -w 32\`"
uniqfiles=`echo $allfiles | uniq -w 32`
echo md5_all="\`comm  <(echo \$allfiles) <(echo \$uniqfiles) -2 -3 | cut -c -32\`"
md5_all=`comm  <(echo $allfiles) <(echo $uniqfiles) -2 -3 | cut -c -32`
echo "uniq_all_files=\`echo \$md5_all |xargs -I {}  grep {} <(echo \$allfiles) \`"
uniq_all_files=`echo $md5_all |xargs -I {}  grep {} <(echo $allfiles) `
echo "\`echo \$uniq_all_files\`"
echo $uniq_all_files