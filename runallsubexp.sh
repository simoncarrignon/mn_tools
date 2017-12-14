###This scritp (its structure) allows to send a batch of splitted jobs (ie= a batch of batch of queued jobs)

last=0
for pref in "AllTimeSet1ProdWithMut5" "AllTimeSet1ProdWithMut1"; do
for exp in  "timeSetSizeOnHighMutLow" "timeSetSizeOnHighCopy" "timeSet" "timeSetRandomCopy" "timeSetSizeOn"; do #
	cd $pref-$exp
	echo $pref-$exp
	for id in 28 30 32; do
 	bash splitTask.sh 2 jobfile/province_timeSet_$id.job $last ; 

	sleep 2
	last=`bjobs | tail -n 1 | awk '{print $1}'`
	done
	cd ..
done
done
