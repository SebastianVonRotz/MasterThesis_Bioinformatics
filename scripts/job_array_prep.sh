#!/bin/bash
#
#SBATCH --job-name=Nanoplot
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


					 

