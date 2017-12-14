#This nice script create a subfolder where subtask of a big expe will be send from
#TODO maybe: named more clearly the job name to be able to linked in a more civilised maneer the job between eachother
for pref in "AllTimeSet1ProdWithMut1" "AllTimeSet1ProdWithMut5"; do
for exp in "timeSetSizeOn" "timeSetSizeOnHighMutLow" "timeSetSizeOnHighCopy" "timeSet" "timeSetRandomCopy"; do
	expfoldname=$pref-$exp
	mkdir $expfoldname
	mkdir $expfoldname/jobfile
	mkdir $expfoldname/taskfile
	mkdir $expfoldname/errfile
	ln -s ~/mn_tools/*  $expfoldname
	cd $expfoldname
	for fold in /gpfs/scratch/bsc21/bsc21394/firstSetFixedGoods/$pref/$exp/*/ ; do 
		./makeNewExperiment.sh $fold 00:25 ../../../ceeculture/ ; 
	done
	cd ..
done
done
