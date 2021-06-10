#!/bin/bash
#
#SBATCH --job-name=Stats_Report_Kraken2
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

# Check if a previous workflow slurm jbo has crashed
if [ -f crash ]; then exit 1; fi

# Export the env file 
export $(cat env)

# Define Output and Input Path
DATA_PATH_IN=../results/$DATASET_NAME/classification_kraken2_nanofilt_$RUN_NAME_IN/
DATA_PATH_OUT=../results/$DATASET_NAME/r_kraken2_report_nanofilt_$RUN_NAME_OUT/

# Create Output dir
mkdir -p $DATA_PATH_OUT

for report in $DATA_PATH_IN*REPORT
  do
    echo $report
    Rscript kraken2_report_stats.R $report $DATA_PATH_OUT$(basename $report)_Stats
  done
			 
# Check if a previous workflow slurm jbo has crashed
if [ -f crash ]; then exit 1; fi
