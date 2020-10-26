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
 
# Load modules of dependencies module purge
module load slurm
module load USS/2020
module load guppy/3.3.3

export $(cat ./$1)

mkdir -p $DATAPATH_DEMULTPLEXING_D1_02_OUT
 

# Run the guppy application here
#guppy_barcoder --help
#guppy_barcoder --print_kits
guppy_barcoder -i $DATAPATH_DEMULTPLEXING_D1_IN -s $DATAPATH_DEMULTPLEXING_D1_02_OUT --flowcell $FLOWCELL_D1 --kit $KIT_D1 --barcode_kits $BARCODING_CONFIG_NAME_D1