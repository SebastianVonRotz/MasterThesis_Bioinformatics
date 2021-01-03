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
#SBATCH --mail-user=voro@zhaw.ch
#
 
# Load modules of dependencies module purge
module load USS/2020
module load gcc/7.3.0 
module load python/3.6.5-pe5.26
module load openblas/0.3.5-haswell-ep
module load py-nanofilt/2.7.1-openblas-py3.6-pe5.26


export $(cat ./$1)
mkdir -p $DATAPATH_FILTER_TRIM_NANOFILT_D4_OUT

for fq in $DATAPATH_FILTER_TRIM_NANOFILT_D4_IN*.fastq
  do
    cat $fq | NanoFilt -q 7 -l 1000 --maxlength 2000  > $DATAPATH_FILTER_TRIM_NANOFILT_D4_OUT$(basename $fq)
  done


