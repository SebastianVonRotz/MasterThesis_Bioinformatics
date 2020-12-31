####################################
# Manifest File
####################################
#
#
# Combination of kit and flowcell
#
CONFIG_NAME=dna_r9.4.1_450bps_hac.cfg
FLOWCELL=FLO-MIN106
KIT=SQK-RAD002
#
#
# Basecalling
#
DATAPATH_BASECALLING_IN=../data/Dataset_test/fast5_tiny/
DATAPATH_BASECALLING_OUT=../results/Dataset_Test_wp_02/basecalled
#
#
# Nanoplot
#
DATAPATH_NANOPLOT_In=../results/Dataset_Test_wp_02/basecalled/sequencing_summary.txt
DATAPATH_NANOPLOT_OUT=../results/Dataset_Test_wp_02/nanoplot
#
#
# Demultiplexing
#
DATAPATH_DEMULTPLEXING_QCAT_OUT=../results/Dataset_Test_wp_02/demultiplexed
#
#
# Filtering / Trimming
#