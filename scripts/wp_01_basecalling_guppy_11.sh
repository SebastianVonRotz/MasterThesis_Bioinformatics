#!/bin/bash
#
#SBATCH --job-name=guppy-batch_basecalling
#
#SBATCH --nodes=4 
#SBATCH --ntasks-per-node=1 
#SBATCH --cpus-per-task=24
#
#SBATCH --time=96:00:00 
#SBATCH --partition=parallel 
#SBATCH --qos=parallel 
#
#SBATCH --mail-type=end 
#SBATCH --mail-user=voro@zhaw.ch
#
 
# Load modules of dependencies module purge
module load slurm
module load USS/2020
module load guppy/3.3.3

export $(cat ./$1)

mkdir -p $DATAPATH_BASECALLING_TEST_11_OUT
 
# Run the guppy application here guppy_basecaller --help guppy_basecaller --print_workflows --compress_fastq
 
guppy_basecaller -i $DATAPATH_BASECALLING_TEST_IN -s $DATAPATH_BASECALLING_TEST_11_OUT -c dna_r9.4.1_450bps_hac.cfg