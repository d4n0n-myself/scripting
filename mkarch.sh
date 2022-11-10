#!/bin/bash

while getopts d:n: flag
do
    case "${flag}" in
        d) dir_path=${OPTARG};;
        n) name=${OPTARG};;
    esac
done

#echo "Path: $dir_path";
#echo "Name: $name";

touch $name.sh

tar -cvzf $name.tar.gz $dir_path 

echo "while getopts o: flag; do" >> $name.sh
echo "	case \${flag} in" >> $name.sh
echo "		o) output_dir=\${OUTARG};;" >> $name.sh
echo "	esac" >> $name.sh
echo "done" >> $name.sh

echo -n "base64 -d " >> $name.sh
base64 $name.tar.gz >> $name.sh
echo -n 'tar -xvf ' >> $name.sh
echo -n ${name} >> $name.sh
echo '.tar.gz' >> $name.sh

chmod 777 $name.sh
