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
DATA_PATH_IN=../results/$DATASET_NAME/classification_kraken2_raw_$RUN_NAME_OUT/
DATA_PATH_OUT=../results/$DATASET_NAME/krona_plots_$RUN_NAME_OUT/

# Create Output dir
mkdir -p $DATA_PATH_OUT

# Run the creation of plots
for fq in $DATA_PATH_IN*REPORT
  do
    cut -f3,5 $fq > $DATA_PATH_OUT$(basename $fq)_KRONA_IN
    # cut -f3,5 BC04.fastq_REPORT > krona_BC04.in

    $PATH_KRONATOOLS $DATA_PATH_OUT$(basename $fq)_KRONA_IN -o $DATA_PATH_OUT$(basename $fq)_Krona.html -t 2 -m 1
    # /cfs/earth/scratch/voro/local_apps/krona/KronaTools-2.7.1/bin/bin/ktImportTaxonomy  krona_BC04.in -o krona_BC04.html -t 2 -m 1
  done



