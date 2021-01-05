#!/bin/bash
#
#SBATCH --job-name=Demultiplexing_Guppy
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

# Export the env file 
export $(cat ./$1)

# Create Output and Input Path
DATA_PATH_IN=../results/$DATASET_NAME/Basecalling_Guppy_Array_$RUN_NAME/
DATA_PATH_OUT=../results/$DATASET_NAME/Demultiplexing_Guppy_$RUN_NAME/

# Create Output dir
mkdir -p $DATA_PATH_OUT

# Run the guppy demutiplexer
GUPPY_DEMULTIPLEXING_PATH -i $DATA_PATH_IN -s $DATA_PATH_OUT --barcode_kits $KIT