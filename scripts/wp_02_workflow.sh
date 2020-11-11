# Define the name of the run
#---------------------------#
RUN_NAME=Test_001
export RUN_NAME
#
#
#Define the manifest file
#------------------------#
MANIFEST_FILE=wp_02_manifest
export MANIFEST_FILE
#
#
# Run the basecalling
#--------------------#
RES=$(sbatch wp_02_basecalling_guppy.sh RUN_NAME MANIFEST_FILE)
#
#
# Run the demultiplexing
#-----------------------#
sbatch --dependency=afterok:${RES##* } wp_02_demultiplexing_qcat.sh RUN_NAME MANIFEST_FILE