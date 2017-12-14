#!/bin/bash
#usage:
##./splitTask.sh num_of_batches original-taskfile original-jobfile subfold


max=$1 #number of subtask
jobfile=$2  #original job file
#taskfile=$2 #original task file
#jobfile=$3  #original job file
#outfold=$4  #folder to put the temporary files (allows to run "parallel master" job) => could/should be replaced by the original jobfile name 

expname=`basename $jobfile`
expname=${expname%.*}
outfold=$expname
taskfile=taskfile/$expname.task


if [ ! -d "$outfold" ]; then
	mkdir $outfold
else
	echo "warning split folder already exist, previous split file may be overwritten"
fi

ntask=`wc -l < "$taskfile" `
nsubtask=$((ntask/max))

echo $nsubtask
i=0
prevjob_id=$3

echo "$taskfile $jobfile $outfold"

max=$(( $max - 1 ))
while [ "$i" -le "$max" ];
do

	echo $i
	head -n "$(( $i * $nsubtask + $nsubtask - 1 ))" "$taskfile"| tail -n +"$(( $i * $nsubtask ))" > $outfold/tmp.task_$i
	sed  -e "s%FILE=$taskfile%FILE=$outfold/tmp.task_$i%" -e "s%#BSUB -n .*%#BSUB -n $nsubtask%" $jobfile > $outfold/tmp.job_$i
	
	if [ $prevjob_id -eq 0 ];
	then
		bsub  < $outfold/tmp.job_$i > $outfold/out
		#this sed (and obviously the one in the else) could be avoided by using a -w with the jobname in stead of the jobid
		prevjob_id=$(sed 's/^Job <\([0-9]\+\)>.*$/\1/' $outfold/out)
		echo "First Job:  $prevjob_id"
	else	
		bsub  -w $prevjob_id < $outfold/tmp.job_$i > $outfold/out
		prevjob_id=$(sed 's/^Job <\([0-9]\+\)>.*$/\1/' $outfold/out)
		echo "$i eme job : $prevjob_id"
	fi
	i=$(( $i + 1 ))
done

