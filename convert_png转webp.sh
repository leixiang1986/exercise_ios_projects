#!bin/bash
#png图片不能压缩，压缩了无法转化
if [ $# == 0 ] ; then
 echo "请输入参数"

exit 0
fi

function FileSuffix() {
    local filename="$1"
    if [ -n "$filename" ]; then
        echo "${filename##*.}"
    fi
}

function FilePrefix() {
    local filename="$1"
    if [ -n "$filename" ]; then
        echo "${filename%.*}"
    fi
}



for file in `ls $1` ; do
 echo ${file}
  if [ $(FileSuffix ${file}) = "png" ] ; then
	echo "正在转化${file}"	
	newFile=$(FilePrefix ${file})
	newFile=${newFile}.webp
	cwebp ${file} -o ${newFile}
  fi
done

