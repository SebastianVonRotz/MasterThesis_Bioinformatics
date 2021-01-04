#!/bin/bash
#
#SBATCH --job-name=guppy-batch_basecalling
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

# Check if a previous workflow slurm jbo has crashed
if [ -f crash ]; then exit 1; fi

# Load modules of dependencies module purge
module load slurm
module load USS/2020
module load gcc/7.3.0
module load openblas/0.3.5-haswell-ep
module load py-nanoplot/1.32.0-openblas-py3.6-pe5.26

# Export the aprameters from the manifest file
source $MANIFEST_FILE 

# Create the result directory
mkdir -p $DATAPATH_NANOPLOT_OUT
 
# Run the guppy application here
NanoPlot --summary  $DATAPATH_BASECALLING_OUTsequencing_summary.txt --loglength -o $DATAPATH_NANOPLOT_OUT

# If the this slurm job fail a crash file is generated
if [ $? != 0 ]; then touch crash; fi
					 

