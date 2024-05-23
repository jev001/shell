#!/bin/bash
#Program

# 定义默认值
find_path="."
depth=""
output_file=""

# 使用 getopts 处理参数
while getopts ":i:o:rp:" opt; do
  case $opt in
    p) find_path="$OPTARG";;
    d) depth="$OPTARG";;
    o) output_file="$OPTARG";;
    \?) echo "Usage: $0 [-p input_path] [-o output_file] [-d depth]" >&2 exit 1;;
  esac
done

# if [ -z "$output_file" ] ; then
#   echo "Usage: $0 [-p input_path] [-o output_file] [-d depth]" >&2
#   exit 1
# fi

allfiles=""
# 检查必需参数是否已设置
if [ -z "$depth" ] ; then
  echo "allfiles=\`find .  -type f -print0 | xargs -0 md5sum | sort |tr '\n' '\0' \`"
  allfiles=`find .  -type f -print0 | xargs -0 md5sum | sort | tr '\n' '\0'`
else
  echo "allfiles=\`find . maxdepth \$depth -type f -print0 | xargs -0 md5sum | sort | tr '\n' '\0' \`"
  allfiles=`find . maxdepth $depth -type f -print0 | xargs -0 md5sum | sort |tr '\n' '\0' `
fi
echo "uniqfiles=\`echo \$allfiles | uniq -w 32 |tr '\n' '\0' \`"
uniqfiles=`echo $allfiles | uniq -w 32|tr '\n' '\0'`

echo md5_all="\`comm  <(echo \$allfiles) <(echo \$uniqfiles) -2 -3 | cut -c -32\ | tr '\n' '\0' \`"
md5_all=`comm  <(echo $allfiles) <(echo $uniqfiles) -2 -3 | cut -c -32|tr '\n' '\0'`

#echo "uniq_all_files=\`echo \$md5_all |xargs -I {}  grep {} <(echo \$allfiles) |tr '\n' '\0' \`"
if [ -z "$output_file" ] ; then
  echo $md5_all |xargs -I {}  grep {} <(echo $allfiles)
else
  echo $md5_all |xargs -I {}  grep {} <(echo $allfiles) >$output_file
  echo "结果已保存到 $output_file 文件。"
fi
