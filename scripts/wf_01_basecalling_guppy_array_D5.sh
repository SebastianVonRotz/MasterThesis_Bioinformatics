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
 
export $(cat ./$1)

mkdir -p $DATAPATH_BASECALLING_D5_ARRAY_OUT

X=($(ls $DATAPATH_BASECALLING_D5_ARRAY_IN |sort))
 
echo Task ID is: $(expr $SLURM_ARRAY_TASK_ID - 1)
echo Subdir is: ${X[$SLURM_ARRAY_TASK_ID-1]}
echo srun /cfs/earth/scratch/voro/local_apps/ont-guppy-cpu/bin/guppy_basecaller -i $DATAPATH_BASECALLING_D5_ARRAY_IN/${X[$SLURM_ARRAY_TASK_ID-1]} -s $DATAPATH_BASECALLING_D5_ARRAY_OUT/run_${X[$SLURM_ARRAY_TASK_ID-1]} --flowcell FLO-FLG001 --kit SQK-16S024
srun /cfs/earth/scratch/voro/local_apps/ont-guppy-cpu/bin/guppy_basecaller -i $DATAPATH_BASECALLING_D5_ARRAY_IN/${X[$SLURM_ARRAY_TASK_ID-1]} -s $DATAPATH_BASECALLING_D5_ARRAY_OUT/run_${X[$SLURM_ARRAY_TASK_ID-1]} --flowcell FLO-FLG001 --kit SQK-16S024
