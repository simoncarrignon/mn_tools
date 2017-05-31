#!/bin/bash

folder=$1
execpath=$2
for i in "$folder"/*/; 
do 
	ln -s $execpath/province $i;
	ln -s $execpath/AnalyseTools/analysis $i;
	#cp -r $execpath/networks $i;
done
