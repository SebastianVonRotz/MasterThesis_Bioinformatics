#!/bin/bash
#
#SBATCH --job-name=Basecalling_RUN_$Run_NAME
#
#SBATCH --nodes=4 
#SBATCH --ntasks-per-node=1 
#SBATCH --cpus-per-task=32
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

export $(cat ./$MANIFEST_FILE | egrep -v "^\s*(#|$)")
mkdir -p $DATAPATH_BASECALLING_OUT$RUN_NAME
 
# Run the guppy application here guppy_basecaller --help guppy_basecaller --print_workflows --compress_fastq
guppy_basecaller -i $DATAPATH_BASECALLING_IN -s $DATAPATH_BASECALLING_OUT$RUN_NAME --cpu_threads_per_caller $SLURM_CPUS_PER_TASK --num_callers $SLURM_NTASKS_PER_NODE -c dna_r9.4.1_450bps_hac.cfg
