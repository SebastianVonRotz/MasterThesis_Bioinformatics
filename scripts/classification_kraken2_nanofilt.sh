#!/bin/bash
#
#SBATCH --job-name=Kraken2_Classification
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

# Check if a previous workflow slurm jbo has crashed
if [ -f crash ]; then exit 1; fi

# Export the env file 
export $(cat env)

# Define Output and Input Path
DATA_PATH_IN=../results/$DATASET_NAME/filter_trim_nanofilt_$RUN_NAME_IN/
DATA_PATH_OUT=../results/$DATASET_NAME/classification_kraken2_nanofilt_$RUN_NAME_OUT/

# Create Output dir
mkdir -p $DATA_PATH_OUT

# Run the Classification for each barcode fastq file
for fq in $DATA_PATH_IN*.fastq
  do
    $PATH_KRAKEN2 --report $DATA_PATH_OUT$(basename $fq)_REPORT --db $PATH_KRAKEN2_DB_GG $fq > $DATA_PATH_OUT$(basename $fq)_OUTPUT
  done

# Check if a previous workflow slurm jbo has crashed
if [ -f crash ]; then exit 1; fi