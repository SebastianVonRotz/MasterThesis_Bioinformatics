#!/bin/bash
#
#SBATCH --job-name=D5_basecalling
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
 
export $(cat ./$1)

mkdir -p $DATAPATH_BASECALLING_D5_OUT
 
# Run the guppy application here
#guppy_barcoder --help
#guppy_barcoder --print_kits
/cfs/earth/scratch/voro/local_apps/ont-guppy-cpu/bin/guppy_basecaller -i $DATAPATH_BASECALLING_D5_IN -s $DATAPATH_BASECALLING_D5_OUT --flowcell FLO-FLG001 --kit SQK-16S024