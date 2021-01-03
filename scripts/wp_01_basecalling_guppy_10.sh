#!/bin/bash
#
#SBATCH --job-name=array_basecaling
#
#SBATCH --nodes=1 
#SBATCH --ntasks-per-node=1 
#SBATCH --cpus-per-task=24
#
#SBATCH --time=96:00:00 
#SBATCH --partition=single
#SBATCH --qos=single
#SBATCH --array=1-10
#
#SBATCH --mail-type=end 
#SBATCH --mail-user=voro@zhaw.ch
#SBATCH --export=ALL,LSFM_HANDLE_ARRAY_JOBS_AS_NORMAL=false
#
 
# Load modules of dependencies module purge
module load slurm
module load USS/2020
module load guppy/3.3.3

export $(cat ./$1)
mkdir -p $DATAPATH_BASECALLING_TEST_10_OUT
 
X=($(ls $DATAPATH_BASECALLING_TEST_ARRAY_IN |sort))


echo $SLURM_ARRAY_TASK_ID-1
echo srun guppy_basecaller -i  $DATAPATH_BASECALLING_TEST_ARRAY_IN/${X[$SLURM_ARRAY_TASK_ID-1]} -s $DATAPATH_BASECALLING_TEST_10_OUT  -c dna_r9.4.1_450bps_hac.cfg
srun guppy_basecaller -i $DATAPATH_BASECALLING_TEST_IN/${X[$SLURM_ARRAY_TASK_ID-1]} -s $DATAPATH_BASECALLING_TEST_10_OUT  -c dna_r9.4.1_450bps_hac.cfg