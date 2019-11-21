#!/bin/bash
mkdir work
for i in {1..62};do
	cp pattern work/col$i
done
color () {
	sed -n "${1}p" < colors
}
symbol () {
	sed -n "${1}p" < alphabet
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
	current_color=$(color "$i")
	current_symbol=$(symbol "$i")
	current_rotation=$(calculate "$current_color")
	sed s/_COLOR_/$current_color/ -i work/col$i
	sed s/_ROTATE_/$current_rotation/ -i work/col$i
	sed s/\\/people\\/a/\\/people\\/$current_symbol/ -i work/col$i
	sed s/a\\/profile/$current_symbol\\/profile/ -i work/col$i
done
cat common > fullcol
cat work/col{1..62} >> fullcol
cat end >> fullcol
rm work/*
rmdir work
