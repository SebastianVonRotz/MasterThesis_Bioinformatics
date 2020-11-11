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
#SBATCH --output=qcat_output
#
 
# Load modules of dependencies module purge
module load USS/2020
module load gcc/7.3.0 
module load python/3.6.5-pe5.26
module load py-setuptools/41.4.0-py3.6-pe5.26


export $(cat ./$1)

mkdir -p $DATAPATH_DEMULTPLEXING_QCAT_OUT

cat $DATAPATH_DEMULTPLEXING_IN/*.fastq | /cfs/earth/scratch/voro/python/bin/qcat -b $DATAPATH_DEMULTPLEXING_QCAT_OUT 2>&1
 
cp qcat_output $DATAPATH_DEMULTPLEXING_QCAT_OUT
rm qcat_output