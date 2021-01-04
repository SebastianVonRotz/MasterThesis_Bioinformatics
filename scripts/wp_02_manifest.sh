# Define the name of the run
RUN_NAME=_Test_004
#
# Remote path on hpc
REMOTE_PATH=/cfs/earth/scratch/voro/scripts
#
# Combination of kit and flowcell
FLOWCELL=FLO-MIN106
KIT=SQK-RAD002
#
# Data Input Path
DATAPATH_IN=../data/Dataset_test/fast5_tiny/
#
# Data Output Path
DATAPATH_OUT=../results/Dataset_Test_wp_02/
#
# Datapath for basecalling
DATAPATH_BASECALLING_OUT=${DATAPATH_OUT}Basecalled$RUN_NAME/
#
# Datapaht for nanoplot
DATAPATH_NANOPLOT_OUT=${DATAPATH_OUT}Nanoplot$RUN_NAME/
#
# Define files for uploading and processing
