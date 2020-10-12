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

Rscript MinIONQC.R ../results/Dataset_test/wf_02_basecalling-guppy_1/sequencing_summary.txt
					 

