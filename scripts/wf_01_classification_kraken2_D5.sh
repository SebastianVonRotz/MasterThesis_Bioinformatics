#!/bin/bash
#
#SBATCH --job-name=kraken2_classification
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
#SBATCH --output=qcat_output
#

# Export the env file 
export $(cat ./$1)

# Crete the Out Dir
mkdir -p $DATAPATH_CLASSIFICATION_KRAKEN2_D5_OUT

# Paths to the kraken2 executable and the corresponding Database
PATH_KRAKEN2=/cfs/earth/scratch/voro/local_apps/kraken2/Kraken_Installation/kraken2 
PATH_DB=/cfs/earth/scratch/voro/local_apps/kraken2/scripts/GREENGENES/

# Run the Classification for each barcode fastq file
for fq in $DATAPATH_CLASSIFICATION_KRAKEN2_D5_IN*.fastq
  do
    $PATH_KRAKEN2 --report $DATAPATH_CLASSIFICATION_KRAKEN2_D5_OUT$(basename $fq)_REPORT --db $PATH_DB $fq > $DATAPATH_CLASSIFICATION_KRAKEN2_D5_OUT$(basename $fq)_CLASSIFICATION
  done