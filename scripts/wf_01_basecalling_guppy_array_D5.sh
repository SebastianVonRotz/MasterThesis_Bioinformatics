#!/bin/bash
#
#SBATCH --job-name=D5_array
#
#SBATCH --nodes=1 
#SBATCH --ntasks-per-node=1 
#SBATCH --cpus-per-task=32
#
#SBATCH --time=96:00:00 
#SBATCH --partition=parallel
#SBATCH --qos=parallel
#SBATCH --array=1-21
#SBATCH --export=ALL,LSFM_HANDLE_ARRAY_JOBS_AS_NORMAL=false
#
#SBATCH --mail-type=end 
#SBATCH --mail-user=voro@zhaw.ch
#

# Export the env file 
export $(cat ./$1)

# Crete the Out Dir
mkdir -p $DATAPATH_BASECALLING_D5_ARRAY_OUT_NEW

# Load all data directory names into an array 
X=($(ls $DATAPATH_BASECALLING_D5_ARRAY_IN |sort))

# based on the task ID of the array a specific directory from the array is processed
echo Task ID is: $(expr $SLURM_ARRAY_TASK_ID - 1)
echo Subdir is: ${X[$SLURM_ARRAY_TASK_ID-1]}

# Run the basecaller
echo srun /cfs/earth/scratch/voro/local_apps/ont-guppy-cpu/bin/guppy_basecaller -i $DATAPATH_BASECALLING_D5_ARRAY_IN/${X[$SLURM_ARRAY_TASK_ID-1]} -s $DATAPATH_BASECALLING_D5_ARRAY_OUT_NEW/${X[$SLURM_ARRAY_TASK_ID-1]} --flowcell $FLOWCELL_D5  --kit $KIT_D5 
srun /cfs/earth/scratch/voro/local_apps/ont-guppy-cpu/bin/guppy_basecaller -i $DATAPATH_BASECALLING_D5_ARRAY_IN/${X[$SLURM_ARRAY_TASK_ID-1]} -s $DATAPATH_BASECALLING_D5_ARRAY_OUT_NEW/${X[$SLURM_ARRAY_TASK_ID-1]} --flowcell $FLOWCELL_D5  --kit $KIT_D5 

# after the fasecaller is run the output names of the fastq files have to be changed
echo rename -v _0.fastq _$(expr $SLURM_ARRAY_TASK_ID - 1).fastq $DATAPATH_BASECALLING_D5_ARRAY_OUT_NEW/${X[$SLURM_ARRAY_TASK_ID-1]}/*.fastq
rename -v _0.fastq _$(expr $SLURM_ARRAY_TASK_ID - 1).fastq $DATAPATH_BASECALLING_D5_ARRAY_OUT_NEW/${X[$SLURM_ARRAY_TASK_ID-1]}/*.fastq

# after renaming the files are put in the parent directory
echo mv $DATAPATH_BASECALLING_D5_ARRAY_OUT_NEW/${X[$SLURM_ARRAY_TASK_ID-1]}/*.fastq $DATAPATH_BASECALLING_D5_ARRAY_OUT_NEW/
mv $DATAPATH_BASECALLING_D5_ARRAY_OUT_NEW/${X[$SLURM_ARRAY_TASK_ID-1]}/*.fastq $DATAPATH_BASECALLING_D5_ARRAY_OUT_NEW/
