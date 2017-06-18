#!/bin/bash
for i in {2..62};do cp col1 col$i;done
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
sed s/green/$var/ -i col$i;
sed s/\\/people\\/a/\\/people\\/$varc/ -i col$i;done
#cat col0 > fullcol
cat col{0..63} > fullcol
#cat col64 > fullcol
