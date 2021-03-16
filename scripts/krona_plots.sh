#!/bin/bash
#
#SBATCH --job-name=Krona_Plots
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
DATA_PATH_IN=../results/$DATASET_NAME/classification_kraken2_raw_$RUN_NAME_IN/
DATA_PATH_OUT=../results/$DATASET_NAME/krona_plots_$RUN_NAME_OUT/

# Create Output dir
mkdir -p $DATA_PATH_OUT

# Run the creation of plots
for fq in $DATA_PATH_IN*REPORT
  do
    $PATH_KRAKEN2KRONA $fq > $DATA_PATH_OUT$(basename $fq)_KRONA_IN
    $PATH_KRONATOOLS $DATA_PATH_OUT$(basename $fq)_KRONA_IN -o $DATA_PATH_OUT$(basename $fq)_Krona.html
  done



