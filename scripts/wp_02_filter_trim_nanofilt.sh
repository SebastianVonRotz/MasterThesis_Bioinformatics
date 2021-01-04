#!/bin/bash
#
#SBATCH --job-name=guppy-batch_basecalling
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
#SBATCH --mail-user=voro@zhaw.chpw
#

# Check if a previous workflow slurm jbo has crashed
if [ -f crash ]; then exit 1; fi

# Load modules of dependencies module purge
module load USS/2020
module load gcc/7.3.0 
module load python/3.6.5-pe5.26
module load openblas/0.3.5-haswell-ep
module load py-nanofilt/2.7.1-openblas-py3.6-pe5.26

# Export the aprameters from the manifest file
source $MANIFEST_FILE 

# Create the result directory
mkdir -p $DATAPATH_FILTER_TRIM_NANOFILT_OUT$RUN_NAME

# Run the application here
for fq in $DATAPATH_DEMULTPLEXING_QCAT_OUT$RUN_NAME/*.fastq
  do
    cat $fq | NanoFilt --maxlength 5000  > $DATAPATH_FILTER_TRIM_NANOFILT_OUT$RUN_NAME$(basename $fq)
  done

# If the this slurm job fail a crash file is generated
if [ $? != 0 ]; then touch crash; fi
