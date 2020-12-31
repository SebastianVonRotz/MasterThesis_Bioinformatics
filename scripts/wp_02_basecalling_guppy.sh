#!/bin/bash
#
#SBATCH --job-name=Basecalling_RUN_$Run_NAME
#
#SBATCH --nodes=4 
#SBATCH --ntasks-per-node=1 
#SBATCH --cpus-per-task=32
#
#SBATCH --time=96:00:00 
#SBATCH --partition=parallel 
#SBATCH --qos=parallel
#
#SBATCH --mail-type=end 
#SBATCH --mail-user=voro@zhaw.ch
#
 
# Check if a previous workflow slurm jbo has crashed
if [ -f crash ]; then exit 1; fi

# Load modules of dependencies module purge
module load slurm
module load USS/2020
module load guppy/3.3.3

# Export the aprameters from the manifest file
source $MANIFEST_FILE 

# Create the result directory
mkdir -p $DATAPATH_BASECALLING_OUT$RUN_NAME
 
# Run the guppy application here guppy_basecaller --help guppy_basecaller --print_workflows --compress_fastq
guppy_basecaller -i $DATAPATH_BASECALLING_IN -s $DATAPATH_BASECALLING_OUT$RUN_NAME --cpu_threads_per_caller $SLURM_CPUS_PER_TASK --num_callers $SLURM_NTASKS_PER_NODE --flowcell $FLOWCELL--kit $KIT

# If the this slurm job fail a crash file is generated
if [ $? != 0 ]; then touch crash; fi