#!/bin/bash
#
#SBATCH --job-name=CRISPR_Finder
#
#SBATCH --nodes=1 
#SBATCH --ntasks-per-node=1 
#SBATCH --cpus-per-task=1
#
#SBATCH --time=96:00:00 
#SBATCH --partition=single 
#SBATCH --qos=single
#
#SBATCH --mail-type=end 
#SBATCH --mail-user=voro@zhaw.ch
#

# Export the env file 
export $(cat env)

# Define Output and Input Path
DATA_PATH_IN=../results/$DATASET_NAME/filter_trim_nanofilt_$RUN_NAME_IN/
DATA_PATH_OUT=../results/$DATASET_NAME/crispr_finder_nanofilt_$RUN_NAME_OUT/

# Command working with a local repository (currently not working)
# $UDOCKER_PATH --repo=/cfs/earth/scratch/voro/local_apps/docker_images run -v /cfs/earth/scratch/voro:/mnt --workdir=/opt/CRISPRCasFinder/ crispr perl CRISPRCasFinder.pl -in /mnt/scripts/sequence.fasta -outdir /mnt/crrtest2 -html

# Comman working with a full start of the image
# $UDOCKER_PATH run -v /cfs/earth/scratch/voro:/mnt --workdir=/opt/CRISPRCasFinder/ unlhcc/crisprcasfinder perl CRISPRCasFinder.pl -in /mnt/scripts/sequence.fasta -outdir /mnt/crrtest2 -html

# Create Output dir
mkdir -p $DATA_PATH_OUT

for fq in $DATA_PATH_IN*.fastq
  do
    fbname=$(basename "$fq" .fastq)
    sed -n '1~4s/^@/>/p;2~4p' $fq > ${DATA_PATH_OUT}${fbname}.fasta
  done

# Run the Classification for each barcode fastq file
 for fq in $DATA_PATH_OUT*.fasta
   do   
        echo $fq
        fbname=$(basename "$fq" .fasta)
        $UDOCKER_PATH run -v ${REMOTE_PATH}/../:/mnt --workdir=/opt/CRISPRCasFinder/ unlhcc/crisprcasfinder perl CRISPRCasFinder.pl -in /mnt/scripts/${fq} -outdir /mnt/scripts/${DATA_PATH_OUT}${fbname} -html
        #$PATH_KRAKEN2 --report $DATA_PATH_OUT$(basename $fq)_REPORT --db $PATH_KRAKEN2_DB_GG $fq > $DATA_PATH_OUT$(basename $fq)_OUTPUT
   done

