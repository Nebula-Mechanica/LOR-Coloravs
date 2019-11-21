#!/bin/bash
DATADIR="data"
TEMPDIR="template"
WORKDIR="work"
mkdir $WORKDIR
for i in {1..62};do
	cp $TEMPDIR/pattern $WORKDIR/col$i
done
color () {
	sed -n "${1}p" < $DATADIR/colors
}
symbol () {
	sed -n "${1}p" < $DATADIR/alphabet
}

calculate () {
	color="${1}"
	#color=$(echo ${color^^}|sed "s/#//g")
	hash=$(echo $color| md5sum -)
	hash=${hash^^}
	hash=${hash:0:6}
	#echo $hash >> log
	decimal=$(echo "ibase=16;$hash"|bc)
	result=$(echo "(($decimal%100)*1.5)/1+55"|bc)
	echo $result
}

for i in {1..62};
do
	#echo $i
	current_color=$(color "$i")
	current_symbol=$(symbol "$i")
	current_saturate=$(calculate "$current_color")
	current_sign=$(echo "$current_saturate%2"|bc)
	if [ $current_sign -eq 0 ];then
		current_sign=-1
	fi
	current_rotate=$(echo "$current_saturate/3*$current_sign"|bc)
	sed s/_COLOR_/$current_color/ -i $WORKDIR/col$i
	sed s/_SATURATE_/$current_saturate/ -i $WORKDIR/col$i
	sed s/_ROTATE_/$current_rotate/ -i $WORKDIR/col$i
	sed s/\\/people\\/a/\\/people\\/$current_symbol/ -i $WORKDIR/col$i
	sed s/a\\/profile/$current_symbol\\/profile/ -i $WORKDIR/col$i
done
#echo "end"
cat $TEMPDIR/common > lor-coloravs.css
cat $WORKDIR/col{1..62} >> lor-coloravs.css
cat $TEMPDIR/end >> lor-coloravs.css
#echo "going to remove $WORKDIR/"
rm $WORKDIR/col*
rmdir $WORKDIR
