#!/bin/bash

while getopts o: flag
do
    case "${flag}" in
        o) output_dir=${OPTARG};;
    esac
done
echo "Username: $output_dir";
# echo 'H4sIAAAAAAAAA+3OMQ7CMBAEQD/FP8DGHHlPpFDQBCkx/ycUkaigCtXMFlvcFdtva5/uyykdqGyG
# iHfXIcpn71K9tNbOcd2SSq3RSspx5Kjdc+3jknOaxvkxf/n7dQcAAAAAAAAAAIA/egEmuYBpACgA
# AA==' | base64 -d
mkdir -p $output_dir
tar -xvf kekw.tar.gz -C $output_dir

