# Run the job array preparation
#
# Because the basecalling_guppy_array.sh needs to be adapted dynamically, the job_array_prep.sh, which adapts it,
# can not be executed as a batch job.
# If it would be executed as a batch job the basecalling_guppy_array.sh would be already in the queue without being adapted beforehand, 
# this is because the dependeny mechanism is only for jobs which are already in the queue
# Also the content of the job_array_prep.sh can be simply processed
#
#--------------------#
# Export the env file 
export $(cat env)
# Define Output and Input Path
DATA_PATH_OUT=$DATA_PATH_IN../${DATASET_NAME}_Array/
# Create Output dir
mkdir -p $DATA_PATH_OUT
# Copy all the fast5 files into the new Directory
cp $DATA_PATH_IN*fast5 $DATA_PATH_OUT
# Create subdirectories
cd $DATA_PATH_OUT
n=0; for f in *.fast5; do d="subdir$((n++ / $FILES_PER_SUBDIR))"; mkdir -p "$d"; mv -- "$f" "$d/$f"; done
# Go back to the remote path
cd $REMOTE_PATH
# Define Output and Input Path
DATA_PATH_IN=$DATA_PATH_IN../${DATASET_NAME}_Array/
# Count files in folder
COUNT=$(find $DATA_PATH_IN -mindepth 1 -maxdepth 1 -type d | wc -l)
# Adapt array basecalling script the file accordingly
sed -i'' -e "s/--array=.*/--array=1-$COUNT/g" basecalling_guppy_array.sh
#
#
# Run the basecalling
#--------------------#
RES1=$(sbatch basecalling_guppy_array.sh)
echo The script basecalling_guppy_array.sh is running with the job id ${RES1##* }
#
#
# Run the nanoplot
#-----------------------#
RES2=$(sbatch --dependency=afterany:${RES1##* } nanoplot_fastq.sh)
echo The script nanoplot_fastq.sh is running with the job id ${RES2##* }
#
#
# Run the Demultiplexing with qcat (paralell to the nanoplot)
#-----------------------#
RES3=$(sbatch --dependency=afterany:${RES1##* } demultiplexing_qcat.sh)
echo The script demultiplexing_qcat.sh is running with the job id ${RES3##* }
#
#
# Run the Filter and Trimming with Nanofilt
#-----------------------#
RES4=$(sbatch --dependency=afterany:${RES3##* } filter_trim_nanofilt.sh)
echo The script filter_trim_nanofilt.sh is running with the job id ${RES4##* }
#
#
# Run the Classification with Kraken
#-----------------------#
RES5=$(sbatch --dependency=afterany:${RES4##* } classification_kraken2_nanofilt.sh)
echo The script classification_kraken2_nanofilt.sh is running with the job id ${RES5##* }
#
#
# Run the Reporting of the Classfication
#-----------------------#
RES6=$(sbatch --dependency=afterany:${RES5##* } r_kraken2_report_nanofilt.sh)
echo The script r_kraken2_report_nanofilt.sh is running with the job id ${RES5##* }
