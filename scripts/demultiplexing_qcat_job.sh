#!/bin/bash
#
#SBATCH --job-name=Demultiplexing_qcat
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
#SBATCH --output=qcat_output
#
 
# Load modules of dependencies module purge
module load USS/2020
module load gcc/7.3.0 
module load python/3.6.5-pe5.26
module load py-setuptools/41.4.0-py3.6-pe5.26

# Export the env file 
export $(cat env)

# Define Output and Input Path
DATA_PATH_IN=../results/$DATASET_NAME/basecalling_guppy_job_$RUN_NAME_IN/
DATA_PATH_OUT=../results/$DATASET_NAME/demultiplexing_qcat_$RUN_NAME_OUT/

# Create Output dir
mkdir -p $DATA_PATH_OUT

# Run the qcat application and copy the command line output to the result folder
cat $DATA_PATH_IN*.fastq | $QCAT_DEMULTIPLEXING_PATH -b $DATA_PATH_OUT 2>&1

# Copy the qcat output to the output folder end remove it from the working dir
cp qcat_output $DATA_PATH_OUT
rm qcat_output