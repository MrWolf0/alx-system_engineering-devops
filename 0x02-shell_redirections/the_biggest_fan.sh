#!/bin/bash
# script that take a path of file to sort it and find the which was repeated a lot
# We can say that it is the most repeated in the file
#this is the last advaced task in 0x02. Shell, I/O Redirections and filters
#called The biggest fan  i will leave some instructed commants 
# 2 list  one for holding data from the frist_res file 
# the second for holding addresses or ips 
# $max is an integer number to specify how many address visit the site
arr=()
host=()
max=1

#exit if no argument pass as $1
if [ "$1" == "" ] || [ $# -gt 1 ]; then
        echo "Error [-] : enter path of file."
        exit 0
fi
#hold path from terminal 
path=$1
#create frist_res and final_res
if [[ ! -f frist_res.txt ]]
then
touch frist_res.txt
fi
if [[ ! -f final_res.txt ]]
then
touch final_res.txt
fi
# opening the file sort it then count how many every host repeated in the file
# removing the first whitespace then sorting from smallest to biggest
cat $path | cut -f 1 | sort | uniq -c | sed -e 's/^[ \t]*//' | sort -n > frist_res.txt
#read from frist_res.txt appand result to arr list
while IFS= read -r line 
do
arr+=($line)
done < frist_res.txt

#comparing the number of max with the first index of the list and append the second index into host list
#doing that by using arithmetic operators

for ((index=0; index<${#arr[@]};index+=2))
do
#the start of comparing from 1 and append also if there is one or more host have the same number of visit
if [[ ${arr[index]} -gt $max || ${arr[index]} -eq $max ]]
then
host+=(${arr[index+1]})
max=${arr[index]}
fi
done
#finally reverse content of file to shown as the most visit at the beginning
for t in ${host[@]}
do 
echo $t >> final_res.txt 
tac final_res.txt  > the_most_hosts.txt
done
# removing unwanted files 
rm final_res.txt  frist_res.txt
#By MRX || Wolf
