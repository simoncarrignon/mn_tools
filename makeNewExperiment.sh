####
# folder = name of the folder with the experiments
# time = duration you want to ask to bsub
#  execpath = path where is the executable
#
folder=$1
time=$2
execpath=$3

#./link.sh $folder $execpath
./makeTask.sh $folder
./makeJobs.sh $folder $time

