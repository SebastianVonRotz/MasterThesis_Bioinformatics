#!/bin/bash
#
#SBATCH --job-name=Basecalling_Guppy_Job
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

# Create Output Path
DATA_PATH_OUT=../results/$DATASET_NAME/Basecalling_Guppy_Job_$RUN_NAME_OUT/

# Create Output dir
mkdir -p $DATA_PATH_OUT
 
# Run the basecaller
$GUPPY_BASECALLER_PATH -i $DATA_PATH_IN -s $DATA_PATH_OUT --flowcell $FLOWCELL  --kit $KIT
