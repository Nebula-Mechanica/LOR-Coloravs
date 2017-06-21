#!/bin/bash
mkdir work
for i in {1..62};do cp pattern work/col$i;done
color () {
sed -n "${1}p" < colors;
}
symbol () {
sed -n "${1}p" < alphabet;
}

for i in {2..62};
do
var=$(color "$i");
varc=$(symbol "$i");
#echo $var;
sed s/green/$var/ -i work/col$i;
sed s/\\/people\\/a/\\/people\\/$varc/ -i work/col$i;done
cat common > fullcol
cat work/col{1..62} >> fullcol
cat end >> fullcol
rm work/*
rmdir work
