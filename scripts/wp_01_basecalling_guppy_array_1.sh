#!/bin/bash
#
#SBATCH --job-name=array_basecaling
#
#SBATCH --nodes=1 
#SBATCH --ntasks-per-node=1 
#SBATCH --cpus-per-task=32
#
#SBATCH --time=96:00:00 
#SBATCH --partition=parallel
#SBATCH --qos=parallel
#SBATCH --array=1-10
#SBATCH --export=ALL,LSFM_HANDLE_ARRAY_JOBS_AS_NORMAL=false
#
#SBATCH --mail-type=end 
#SBATCH --mail-user=voro@zhaw.ch
#
 
# Load modules of dependencies module purge
module load slurm
module load USS/2020
module load guppy/3.3.3

# Export the env file
export $(cat ./$1)

# Crete the Out Dir
mkdir -p $DATAPATH_BASECALLING_TEST_ARRAY_1_OUT
 
# Load all data directory names into an array 
X=($(ls $DATAPATH_BASECALLING_TEST_ARRAY_IN |sort))


# based on the task ID of the array a specific directory from the array is processed
echo Task ID is: $(expr $SLURM_ARRAY_TASK_ID - 1)
echo Subdir is: ${X[$SLURM_ARRAY_TASK_ID-1]}

# Rund the basecaller
echo srun guppy_basecaller -i  $DATAPATH_BASECALLING_TEST_ARRAY_IN/${X[$SLURM_ARRAY_TASK_ID-1]} -s $DATAPATH_BASECALLING_TEST_ARRAY_1_OUT/${X[$SLURM_ARRAY_TASK_ID-1]}  -c dna_r9.4.1_450bps_hac.cfg
srun guppy_basecaller -i  $DATAPATH_BASECALLING_TEST_ARRAY_IN/${X[$SLURM_ARRAY_TASK_ID-1]} -s $DATAPATH_BASECALLING_TEST_ARRAY_1_OUT/${X[$SLURM_ARRAY_TASK_ID-1]}  -c dna_r9.4.1_450bps_hac.cfg

# after the fasecaller is run the output names of the fastq files have to be changed
echo rename -v s/_0.fastq/_$(expr $SLURM_ARRAY_TASK_ID - 1).fastq/ $DATAPATH_BASECALLING_TEST_ARRAY_1_OUT/${X[$SLURM_ARRAY_TASK_ID-1]}/*
rename -v _0.fastq _$(expr $SLURM_ARRAY_TASK_ID - 1).fastq $DATAPATH_BASECALLING_TEST_ARRAY_1_OUT/${X[$SLURM_ARRAY_TASK_ID-1]}/*.fastq

# after renaming the files are put in the parent directory
echo mv $DATAPATH_BASECALLING_TEST_ARRAY_1_OUT/${X[$SLURM_ARRAY_TASK_ID-1]}/*.fastq $DATAPATH_BASECALLING_TEST_ARRAY_1_OUT/
mv $DATAPATH_BASECALLING_TEST_ARRAY_1_OUT/${X[$SLURM_ARRAY_TASK_ID-1]}/*.fastq $DATAPATH_BASECALLING_TEST_ARRAY_1_OUT/


