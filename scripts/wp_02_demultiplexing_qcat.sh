#!/bin/bash
#
#SBATCH --job-name=Demultiplexing_Run_$RUN_NAME
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
 
# Check if a previous workflow slurm jbo has crashed
if [ -f crash ]; then exit 1; fi

# Load modules of dependencies module purge
module load USS/2020
module load gcc/7.3.0 
module load python/3.6.5-pe5.26
module load py-setuptools/41.4.0-py3.6-pe5.26

# Export the aprameters from the manifest file
source $MANIFEST_FILE

# Create the result directory
mkdir -p $DATAPATH_DEMULTPLEXING_QCAT_OUT$RUN_NAME

# Run the qcat application and copy the command line output to the result folder
cat $DATAPATH_BASECALLING_OUT$RUN_NAME/*.fastq | /cfs/earth/scratch/voro/python/bin/qcat -b $DATAPATH_DEMULTPLEXING_QCAT_OUT$RUN_NAME 2>&1
cp qcat_output $DATAPATH_DEMULTPLEXING_QCAT_OUT$RUN_NAME
rm qcat_output

# If the this slurm job fail a crash file is generated
if [ $? != 0 ]; then touch crash; fi
 

