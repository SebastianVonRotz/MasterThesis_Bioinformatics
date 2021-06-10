#!/bin/bash
#
#SBATCH --job-name=n010
#
#SBATCH --nodes=1 
#SBATCH --ntasks-per-node=1 
#SBATCH --cpus-per-task=1
#
#SBATCH --time=96:00:00 
#SBATCH --partition=single
#SBATCH --qos=single -w node010
#
#SBATCH --mail-type=end 
#SBATCH --mail-user=voro@zhaw.ch
#

sleep 3d