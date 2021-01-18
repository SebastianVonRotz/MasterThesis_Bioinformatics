#!/bin/bash
#
#SBATCH --job-name=Nanoplot_Summary
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
 
# Load modules of dependencies module purge
module load slurm
module load USS/2020
module load gcc/7.3.0
module load openblas/0.3.5-haswell-ep
module load py-nanoplot/1.32.0-openblas-py3.6-pe5.26

# Export the env file 
export $(cat env)

# Define Output and Input Path
DATA_PATH_IN=../results/$DATASET_NAME/basecalling_guppy_job_$RUN_NAME_OUT/
DATA_PATH_OUT=../results/$DATASET_NAME/nanoplot_sum_$RUN_NAME_OUT/

# Create Output dir
mkdir -p $DATA_PATH_OUT

NanoPlot --summary  ${DATA_PATH_IN}sequencing_summary.txt --loglength -o $DATA_PATH_OUT  

					 

