#!/bin/bash
#
#SBATCH --job-name=guppy-batch_basecalling
#
#SBATCH --nodes=1 
#SBATCH --ntasks-per-node=1 
#SBATCH --cpus-per-task=12
#
#SBATCH --time=96:00:00 
#SBATCH --partition=single 
#SBATCH --qos=single
#
#SBATCH --mail-type=end 
#SBATCH --mail-user=voro@zhaw.ch
#

export $(cat ./$1)

mkdir -p $DATAPATH_DEMULTPLEXING_D4_OUT
 

# Run the guppy application here
#guppy_barcoder --help
#guppy_barcoder --print_kits
/cfs/earth/scratch/voro/local_apps/ont-guppy-cpu/bin/guppy_barcoder -i $DATAPATH_DEMULTPLEXING_D4_IN -s $DATAPATH_DEMULTPLEXING_D4_OUT --barcode_kits $KIT_D4