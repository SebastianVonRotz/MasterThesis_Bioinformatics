#!/bin/bash
#
#SBATCH --job-name=guppy-batch_basecalling
#
#SBATCH --nodes=1 
#SBATCH --ntasks-per-node=1 
#SBATCH --cpus-per-task=32
#
#SBATCH --time=96:00:00 
#SBATCH --partition=single 
#SBATCH --qos=single
#
#SBATCH --mail-type=end 
#SBATCH --mail-user=voro@zhaw.ch
#
 
# Load modules of dependencies module purge
module load USS/2020
module load gcc/7.3.0 
module load python/3.6.5-pe5.26
module load openblas/0.3.5-haswell-ep
module load py-nanofilt/2.7.1-openblas-py3.6-pe5.26


# Export the env file 
export $(cat env)

# Define Output and Input Path
DATA_PATH_IN=../results/$DATASET_NAME/demultiplexing_qcat_$RUN_NAME_OUT/
DATA_PATH_OUT=../results/$DATASET_NAME/filter_trim_nanofilt_$RUN_NAME_OUT/

# Create Output dir
mkdir -p $DATA_PATH_OUT

# Filter each barcoded fastq file
for fq in $DATA_PATH_IN*.fastq
  do
    cat $fq | NanoFilt -q $NANOFILT_QSCORE -l $NANOFILT_MIN_LENGTH --maxlength $NANOFILT_MAX_LENGTH  > $DATA_PATH_OUT$(basename $fq)
  done


