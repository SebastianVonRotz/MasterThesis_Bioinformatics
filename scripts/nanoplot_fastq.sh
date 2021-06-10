#!/bin/bash
#
#SBATCH --job-name=Nanoplot
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
 
# Load modules of dependencies module purge
module load slurm
module load USS/2020
module load gcc/7.3.0
module load openblas/0.3.5-haswell-ep
module load py-nanoplot/1.32.0-openblas-py3.6-pe5.26

# Check if a previous workflow slurm jbo has crashed
if [ -f crash ]; then exit 1; fi

# Export the env file 
export $(cat env)

# Define Output and Input Path
DATA_PATH_IN=../results/$DATASET_NAME/basecalling_guppy_array_$RUN_NAME_IN/
DATA_PATH_OUT=../results/$DATASET_NAME/nanoplot_fastq_$RUN_NAME_OUT/

# Create Output dir
mkdir -p $DATA_PATH_OUT

# Coppy all fastq files to the nanoplot output folder
cat $DATA_PATH_IN*.fastq > ${DATA_PATH_OUT}aggregated.fastq

# Run the NanoPlot application
NanoPlot --fastq  ${DATA_PATH_OUT}aggregated.fastq --loglength -o $DATA_PATH_OUT

# Delete the aggregated fastq file
rm ${DATA_PATH_OUT}aggregated.fastq

					 
# Check if a previous workflow slurm jbo has crashed
if [ -f crash ]; then exit 1; fi
