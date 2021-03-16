# POND a Framework for Processing Of Nanopore Data

![HPC_Server_Interaction](https://github.com/SebastianVonRotz/POND/blob/master/assets/POND_Logo.JPG){:style="float: right;margin-right: 7px;margin-top: 7px;"}

![HPC_Server_Interaction](/assets/POND_Logo.JPG){:height="700px" width="400px"}

This framework enables a simple script based aproach for automated processing of nanopore data on a remote server with a Slurm Workload Manager.

## Install

1. Clone this project.  

    `git clone https://...` 

1. Setup SSH-Keypair. `

    `ssh-keygen -t rsa`

1.  Upload public SSH key to `head.hpc.zhaw.ch`.

    `ssh-copy-id demo@198.51.100.0`

1. Create an alias for task script in your `.bashrc/.zshrc` (simply paste the alias command in the file at the bottom).

    `alias task='./task'`

1. Setup and env file and define the REMOTEPATH, which points to the directorie in which you want to setup the following working area

    `REMOTE_PATH= <Path_to_User> (e.g. REMOTE_PATH=/cfs/earth/scratch/$User/work_area/scripts/)` 

1. Check the if the task-commands are setup by running

    `task help`

1. Create the directories at the remote path

    `task init`

## Overview of the user setup
The task-commands simplify the interaction with a high performance computing envrironment run on the Slurm Workload Manager. This setup is designed and tested to run on the hardware and software envrionment at ZHAW, altought the general concept and scripts should be transferable to other systems. The following picture depicts an overview of the user interaction.
![HPC_Server_Interaction](https://github.com/SebastianVonRotz/POND/blob/master/assets/HPC_Server_Interaction.JPG)

## Overview of processing scripts on the HPC
Scripts process and transform data in a sequential order. This sequenced processing of the data is depicted in the following picture. Depending on the script certain processing steps need to be fullfilled in order to get the correct inpurt for the current script.

![Scripts_Processing_Overview](https://github.com/SebastianVonRotz/POND/blob/master/assets/Scripts_Processing_Overview.JPG)



## Creating an env file
The env file defines variables and parameters which have to be adapted based on installed tools and user envrionment. Each part of the necessary variables is explained in detail in the section "Explanation of the env file content"

1. Create an env file and edit it

`nano env`

2. Add the following to the env file:
```
REMOTE_PATH=/cfs/earth/scratch/voro/scripts
DATASET_NAME=Dataset_5
DATA_PATH_IN=../data/Dataset_5/
RUN_NAME_IN=Step_01
RUN_NAME_OUT=Step_01
FLOWCELL=FLO-FLG001
KIT=SQK-16S024
FILES_PER_SUBDIR=20
GUPPY_BASECALLER_PATH=../local_apps/ont-guppy-cpu/bin/guppy_basecaller
GUPPY_DEMULTIPLEXING_PATH=../local_apps/ont-guppy-cpu/bin//guppy_barcoder
QCAT_DEMULTIPLEXING_PATH=../python/bin/qcat
NANOFILT_QSCORE=7
NANOFILT_MIN_LENGTH=1000
NANOFILT_MAX_LENGTH=2000
PATH_KRAKEN2=../local_apps/kraken2/Kraken_Installation/kraken2 
PATH_KRAKEN2_DB=../local_apps/kraken2/scripts/GREENGENES/
PATH_KRONATOOLS=../local_apps/krona/KronaTools-2.7.1/bin/bin/ktImportTaxonomy
```

3. **or** adapt the "env-template" and rename it to "env"

## Step by Step Processing of Scripts
This section describes the step by step processing of data

1. Prerequisite: Section "Install" is successfuly executed

1. Prerequisite: Section "Creating an env file" is successfuly executed

1. Transfer data into the directory path with the following command (This has to be executed on the HPC). It is important the the corresponding raw data .fast5 files are with the directory named accodirng to the DATASET_NAME (no subddirectories allowed).

`cp -avr <Path to dir with Data> <$USER/WorkArea/data>`

1. Check that necessary variables are set to run a specific script, then use the following command.

`run script <Name of the scrip>`

## Workflow Processing of Scripts
This section describes the execution of a workflow

1. Prerequisite: Section "Install" is successfuly executed

1. Prerequisite: Section "Creating an env file" is successfuly executed



## Available scripts and programs
![Scripts_Detailed.JPG](https://github.com/SebastianVonRotz/POND/blob/master/assets/Scripts_Detailed.JPG)

## Explanation of the env file content

[Env File Content](https://github.com/SebastianVonRotz/POND/blob/master/env_file_content.md)
