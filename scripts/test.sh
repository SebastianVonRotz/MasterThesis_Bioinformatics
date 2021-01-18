#!/bin/bash
#
#SBATCH --job-name=Basecalling_Array
#
#SBATCH --nodes=1 
#SBATCH --ntasks-per-node=1 
#SBATCH --cpus-per-task=4
#
#SBATCH --time=96:00:00 
#SBATCH --partition=parallel
#SBATCH --qos=parallel
#SBATCH --array=1-$ARRNUM
#
#SBATCH --mail-type=end 
#SBATCH --mail-user=voro@zhaw.ch
#


