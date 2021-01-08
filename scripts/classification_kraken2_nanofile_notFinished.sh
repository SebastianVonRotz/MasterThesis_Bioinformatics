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

# Export the env file 
export $(cat env)

# Define Output and Input Path
DATA_PATH_IN=../results/$DATASET_NAME/Demultiplexing_qcat_$RUN_NAME_IN/
DATA_PATH_OUT=../results/$DATASET_NAME/Classification_Kraken2_$RUN_NAME_OUT/

# Create Output dir
mkdir -p $DATA_PATH_OUT

# Run the Classification for each barcode fastq file
for fq in $DATA_PATH_IN*.fastq
  do
    $PATH_KRAKEN2 --report $DATA_PATH_OUT$(basename $fq)_REPORT --db $PATH_KRAKEN2_DB $fq > $DATA_PATH_OUT$(basename $fq)_OUTPUT
  done

