#!/bin/bash
#
#SBATCH --job-name=guppy-batch_basecalling
#
#SBATCH --nodes=1 
#SBATCH --ntasks-per-node=2 
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
module load r/3.6.2-openblas-py3.6-pe5.26
module load r-devtools/2.2.1-openblas-r3.6-py3.6-pe5.26 
module load r-withr/2.1.2-openblas-r3.6-py3.6-pe5.26
R

myPaths = .libPaths()
myPaths = c(myPaths, "/cfs/earth/scratch/voro/local_apps/r_packages")
.libPaths(myPaths)

withr::with_libpaths(new = "/cfs/earth/scratch/voro/local_apps/r_packages",
                     code = install.packages(c("data.table", 
                   "futile.logger",
                   "ggplot2",
                   "optparse",
                   "plyr",
                   "readr",
                   "reshape2",
                   "scales",
                   "viridis",
                   "yaml")))
					 




export $(cat ./$1)

mkdir -p $DATAPATH_BASECALLING_D3_2_OUT
 
# Run the guppy application here guppy_basecaller --help guppy_basecaller --print_workflows --compress_fastq
 
guppy_basecaller -i $DATAPATH_BASECALLING_TEST_IN -s $DATAPATH_BASECALLING_D3_2_OUT --cpu_threads_per_caller $SLURM_CPUS_PER_TASK --num_callers $SLURM_NTASKS_PER_NODE --flowcell FLO-MIN106 --kit SQK-LSK109
