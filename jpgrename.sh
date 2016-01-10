#!/system/bin/sh
#
#This shell to rename a or some jpg files
#some jpg file name are like this : IMG_200315_135037.jpg
#when we sort them,the sort are not arange by date
#so this shell will change its name to IMG_20150320_135037.jpg
#
# Usage: jpgrename dirname
#

preYear=20
maxdepth=2

alias find='busybox find'
alias cut='busybox cut'

if [ -d $1 ]; then
filenames=`find $1 -maxdepth $maxdepth -name "IMG_??????_??????.jpg" -print`
elif [ -f $1 ]; then
if [ `echo $1 | cut -c 1` != '/' ]; then
filenames=./$1
fi
else
echo "No such file or directory: $1"
fi
#echo $filenames
count=0
#filearr=$(echo $filenames)
for item in $filenames
do
oldFileName=$item
item1=${item%/*}
item=${item#$item1}
item2=`echo $item | cut -c 1-5`
item3=`echo $item | cut -c 6-7`
item4=`echo $item | cut -c 8-9`
item5=`echo $item | cut -c 10-11`
item6=`echo $item | cut -c 12-`
newFileName=$item1$item2$preYear$item5$item4$item3$item6
mv $oldFileName $newFileName
#echo $oldFileName-$newFileName
#echo ll
let count++
done
echo Total rename $count files
