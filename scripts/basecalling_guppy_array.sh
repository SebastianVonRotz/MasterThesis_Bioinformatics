#!/bin/bash
#
#SBATCH --job-name=Arr_Basecalling
#
#SBATCH --nodes=1 
#SBATCH --ntasks-per-node=1 
#SBATCH --cpus-per-task=32
#
#SBATCH --time=96:00:00 
#SBATCH --partition=single
#SBATCH --qos=single
#SBATCH --array=1-100
#
#SBATCH --mail-type=end 
#SBATCH --mail-user=voro@zhaw.ch
#

# Check if a previous workflow slurm jbo has crashed
if [ -f crash ]; then exit 1; fi

# Export the env file 
export $(cat env)

# Create Output Path
DATA_PATH_OUT=../results/$DATASET_NAME/basecalling_guppy_array_$RUN_NAME_OUT/

# Create Output dir
mkdir -p $DATA_PATH_OUT

# Define Input Path with Arrays
DATA_PATH_IN=$DATA_PATH_IN../${DATASET_NAME}_Array/

# Load all data directory names into an array 
X=($(ls $DATA_PATH_IN |sort))

# based on the task ID of the array a specific directory from the array is processed
echo Task ID is: $(expr $SLURM_ARRAY_TASK_ID - 1)
echo Subdir is: ${X[$SLURM_ARRAY_TASK_ID-1]}

# Run the basecaller
srun $GUPPY_BASECALLER_PATH -i $DATA_PATH_IN${X[$SLURM_ARRAY_TASK_ID-1]} -s $DATA_PATH_OUT${X[$SLURM_ARRAY_TASK_ID-1]} --flowcell $FLOWCELL  --kit $KIT

# after the fasecaller is run the output names of the fastq files have to be changed
rename -v _0.fastq _$(expr $SLURM_ARRAY_TASK_ID - 1).fastq $DATA_PATH_OUT/${X[$SLURM_ARRAY_TASK_ID-1]}/*.fastq

# after renaming the files are put in the parent directory
mv $DATA_PATH_OUT${X[$SLURM_ARRAY_TASK_ID-1]}/*.fastq $DATA_PATH_OUT

# Check if a previous workflow slurm jbo has crashed
if [ -f crash ]; then exit 1; fi