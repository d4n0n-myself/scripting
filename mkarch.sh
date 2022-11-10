#!/bin/bash

while getopts d:n: flag
do
    case "${flag}" in
        d) dir_path=${OPTARG};;
        n) name=${OPTARG};;
    esac
done

echo "Path: $dir_path";
echo "Name: $name";

touch $name.sh

tar -cvzf $name.tar.gz $dir_path 

base64 $name.tar.gz >> $name.sh 
echo ' | base64 -d' >> $name.sh
echo '\ntar -xvf $name.tar.gz' >> $name.sh

chmod 777 $name.sh
