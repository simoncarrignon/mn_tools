

id=1
for cult in prod integ; do
    for init in man rand randn; do
	for volsel in gin gino; do
	    for ufun in cust gin; do
		./runExp.sh "$id"_cult-"$cult"_init-"$init"_volsel-"$volsel"_ufun-"$ufun" configfiles/"$id"_cult-"$cult"_init-"$init"_volsel-"$volsel"_ufun-"$ufun"_config.xml > logdebug_"$id"_cult-"$cult"_init-"$init"_volsel-"$volsel"_ufun-"$ufun"
		id=$(( id + 1 ))
	    done
	done
    done
done
