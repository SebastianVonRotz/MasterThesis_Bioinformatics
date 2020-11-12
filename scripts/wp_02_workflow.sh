# Define the name of the run
#---------------------------#
export RUN_NAME=_Test_003
#
#
#Define the manifest file
#------------------------#
export MANIFEST_FILE=wp_02_manifest.sh
#
#
# Run the basecalling
#--------------------#
RES1=$(sbatch wp_02_basecalling_guppy.sh RUN_NAME MANIFEST_FILE)
echo The script wp_02_basecalling_guppy.sh is running with the job id ${RES1##* }
#
#
# Run the demultiplexing
#-----------------------#
RES2=$(sbatch --dependency=afterany:${RES1##* } wp_02_demultiplexing_qcat.sh RUN_NAME MANIFEST_FILE)
echo The script wp_02_demultiplexing_qcat.sh is running with the job id ${RES2##* }