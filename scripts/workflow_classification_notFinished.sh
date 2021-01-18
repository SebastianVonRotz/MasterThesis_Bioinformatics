#Define the manifest file
#------------------------#
#
#
# Run the basecalling
#--------------------#
RES1=$(sbatch wp_02_basecalling_guppy.sh MANIFEST_FILE)
echo The script wp_02_basecalling_guppy.sh is running with the job id ${RES1##* }
#
#
# Run the nanoplot
#-----------------------#
#RES2=$(sbatch --dependency=afterany:${RES1##* } wp_02_nanoplot.sh RUN_NAME MANIFEST_FILE)
#echo The script wp_02_nanoplot.sh is running with the job id ${RES2##* }
#
#
# Run the demultiplexing (paralell to the nanoplot)
#-----------------------#
#RES3=$(sbatch --dependency=afterany:${RES1##* } wp_02_demultiplexing_qcat.sh RUN_NAME MANIFEST_FILE)
#echo The script wp_02_demultiplexing_qcat.sh is running with the job id ${RES3##* }
#
#
# Run the nanofilt
#-----------------------#
