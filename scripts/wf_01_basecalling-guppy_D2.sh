#!/bin/bash
#
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

DATAPATH_BASECALLING_D2_IN="../data/Dataset_2/ZHAW_run_0007d/20191030_0900_MN19154_FAL53437_be571480/fast5_pass"
DATAPATH_BASECALLING_D2_OUT="../results/Dataset_2/wf_01_basecalling-guppy_D2/"

 
# Run the guppy application here guppy_basecaller --help guppy_basecaller --print_workflows --compress_fastq
 
guppy_basecaller -i $DATAPATH_BASECALLING_D2_IN -s $DATAPATH_BASECALLING_D2_OUT --cpu_threads_per_caller $SLURM_CPUS_PER_TASK --num_callers $SLURM_NTASKS_PER_NODE --flowcell FLO-MIN106 --kit SQK-LSK109
