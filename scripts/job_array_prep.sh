#!/bin/bash
#
#SBATCH --job-name=Job_Array_Preparation
#
#SBATCH --nodes=1 
#SBATCH --ntasks-per-node=1 
#SBATCH --cpus-per-task=1
#
#SBATCH --time=96:00:00 
#SBATCH --partition=single 
#SBATCH --qos=single
#
#SBATCH --mail-type=end 
#SBATCH --mail-user=voro@zhaw.ch
#

# Check if a previous workflow slurm jbo has crashed
if [ -f crash ]; then exit 1; fi
 
# Export the env file 
export $(cat env)

# Define Output and Input Path
DATA_PATH_OUT=$DATA_PATH_IN../${DATASET_NAME}_Array/

# Create Output dir
mkdir -p $DATA_PATH_OUT

# Copy all the fast5 files into the new Directory
cp $DATA_PATH_IN*fast5 $DATA_PATH_OUT

# Create subdirectories
cd $DATA_PATH_OUT
n=0; for f in *.fast5; do d="subdir$((n++ / $FILES_PER_SUBDIR))"; mkdir -p "$d"; mv -- "$f" "$d/$f"; done

# Go back to the remote path
cd $REMOTE_PATH

# Define Output and Input Path
DATA_PATH_IN=$DATA_PATH_IN../${DATASET_NAME}_Array/

# Count files in folder
COUNT=$(find $DATA_PATH_IN -mindepth 1 -maxdepth 1 -type d | wc -l)

# Adapt array basecalling script the file accordingly
sed -i'' -e "s/--array=.*/--array=1-$COUNT/g" basecalling_guppy_array.sh

# If the this slurm job fail a crash file is generated
if [ $? != 0 ]; then touch crash; fi
					 