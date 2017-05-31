#!/bin/bash

max=$1
taskfile=$2
jobfile=$3
outfold=$4


ntask=`wc -l < "$taskfile" `
nsubtask=$((ntask/max))

echo $nsubtask
i=0
prevjob_id=0

while [ "$i" -le "$max" ];
do

	echo $i
	head -n "$(( $i * $nsubtask + $nsubtask -1 ))" "$taskfile"| tail -n +"$(( $i * $nsubtask ))" > $outfold/tmp.task_$i
	sed  -e "s%FILE=$taskfile%FILE=$outfold/tmp.task_$i%" -e "s%#BSUB -n .*%#BSUB -n $nsubtask%" $jobfile > $outfold/tmp.job_$i
	
	if [ $prevjob_id -eq 0 ];
	then
		bsub  < $outfold/tmp.job_$i > $outfold/out
		prevjob_id=$(sed 's/^Job <\([0-9]\+\)>.*$/\1/' $outfold/out)
		echo "First Job:  $prevjob_id"
	else	
		bsub  -w $prevjob_id < $outfold/tmp.job_$i > $outfold/out
		prevjob_id=$(sed 's/^Job <\([0-9]\+\)>.*$/\1/' $outfold/out)
		echo "$i eme job : $prevjob_id"
	fi
	i=$(( $i + 1 ))
done

