
folder=$1

file="taskfile/province_`basename $folder`.task"
touch $file
for i in $folder/*/ ; 
do
	echo "cd $i && ./province && ./analysis && rm ./data/* && rm ./logs/* "  >> $file
done
