#!/bin/bash
while getopts o: flag; do
	case ${flag} in
		o) output_dir=${OUTARG};;
	esac
done
res="H4sIAAAAAAAAA+3RTQqDMBBA4TlKbtD8zCTnEbQgFAua3r8KFdpN7SYL6fs2s8hABl4dltqP80Ua
8qtits1QzL/PnQRNSS2WUJL4ECyaOGt51O6x1G52Tvpuuk9f9o7eT6q++l/H2xAa/bEFzqq/9c95
7R9VvTjf6J4Pf94fAAAAAAAAAAAAAAAAwHk9AeTH/v8AKAAA"
if [ $output_dir ]
then
mkdir $output_dir
else
mkdir test
fi
if [ $output_dir ]
then
echo "$res" | base64 -d | tar -xvz -C $output_dir 
else
echo "$res" | base64 -d | tar -xvz -C test 
fi
