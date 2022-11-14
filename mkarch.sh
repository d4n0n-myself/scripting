#!/bin/bash

while getopts d:n: flag
do
    case "${flag}" in
        d) dir_path=${OPTARG};;
        n) name=${OPTARG};;
    esac
done

touch $name.sh

base64res=$(tar -cz $dir_path | base64)

echo "#!/bin/bash" >> $name.sh
echo "while getopts o: flag; do" >> $name.sh
echo "	case \${flag} in" >> $name.sh
echo "		o) output_dir=\${OUTARG};;" >> $name.sh
echo "	esac" >> $name.sh
echo "done" >> $name.sh

echo "res=\"$base64res\"" >> $name.sh

echo "if [ \$output_dir ]" >> $name.sh
echo "then" >> $name.sh
echo "mkdir \$output_dir" >> $name.sh
echo "else" >> $name.sh
echo "mkdir ${name}" >> $name.sh
echo "fi" >> $name.sh

echo "if [ \$output_dir ]" >> $name.sh
echo "then" >> $name.sh
echo "echo \"\$res\" | base64 -d | tar -xz -C \$output_dir " >> $name.sh
echo "else" >> $name.sh
echo "echo \"\$res\" | base64 -d | tar -xz -C ${name} " >> $name.sh
echo "fi" >> $name.sh

chmod 777 $name.sh
