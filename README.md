# POND a Framework for the Processing Of Nanopore Data

<img align="left" img src="assets/POND_Logo.JPG" width="150">

This framework enables a simple script based approach for automated processing of nanopore data on a remote server with a Slurm Workload Manager. It requires a unix shell for setting the alias commands and the installation of the tools needed for each processing steps. The tools are either available as a modules on slurm or are installed with a local user. Every script can be run in a step by step manner, but the user has check that the the dependent scripts are processed before each other. The automation is implemented with the dependency command in the slurm environment.
<br/>
<br/>
<br/>

## Installation

1. Clone this project.  

    `git clone https://...` 

1. Setup SSH-Keypair. `

    `ssh-keygen -t rsa`

1.  Upload public SSH key to `head.hpc.zhaw.ch`.

    `ssh-copy-id demo@198.51.100.0`

1. Create the alias commands for the execution of scripts and workflows in your `.bashrc/.zshrc` (simply paste the alias command in the file at the bottom).

    `alias task='./task'`

1. Setup and env file and define the REMOTEPATH, which points to the directory in which you want to create the following working area

    `REMOTE_PATH= <Path_to_User> (e.g. REMOTE_PATH=/cfs/earth/scratch/$User/work_area/scripts/)` 

1. Check the if the task-commands are setup by running

    `task help`

1. Create the directories at the remote path

    `task init`

## Overview of the user setup
The task commands simplify the interaction with the Slurm task manager on the high performance computing environment. This setup is designed and tested to run on the hardware and software envrionment at ZHAW, altought the general concept and scripts should be transferable to other systems. The following picture depicts an overview of the user interaction.
![HPC_Server_Interaction](https://github.com/SebastianVonRotz/POND/blob/master/assets/Section_5.2_POND_Server_Interaction.jpg)

## Overview of processing scripts on the HPC
Scripts process and transform data in a sequential order. This sequenced processing of the data is depicted in the following picture. Depending on the script certain processing steps need to be fullfilled in order to get the correct input for the current and next script.

![Scripts_Processing_Overview](https://github.com/SebastianVonRotz/POND/blob/master/assets/Section_5.2_POND_Scripts_Flow.jpg)

## Creating an env file
The env file defines variables and parameters, which have to be adapted based on installed tools and the specific user envrionment. Each part of the defined variables is explained in detail in the section "Explanation of the env file content"

1. Create an env file and edit it

`nano env`

2. Add the following to the env file:
```
REMOTE_PATH=/cfs/earth/scratch/voro/scripts

DATASET_NAME=Dataset_XY
DATA_PATH_IN=../data/Dataset_XY/
RUN_NAME_IN=RunName
RUN_NAME_OUT=RunName

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
PATH_KRAKEN2_DB_SILVA=../local_apps/kraken2/Kraken_Installation/SILVA/
PATH_KRAKEN2_DB_RDP=../local_apps/kraken2/Kraken_Installation/RDP/
PATH_KRAKEN2_DB_GG=../local_apps/kraken2/scripts/GREENGENES/

PATH_KRONATOOLS=../local_apps/krona/KronaTools-2.7.1/bin/bin/ktImportText
PATH_KRAKEN2KRONA=../local_apps/lskScripts/scripts/kraken2-translate.pl

UDOCKER_PATH=../local_apps/udocker
```

3. **or** adapt the "env-template" and rename it to "env"

## Step by Step Processing of Scripts
This section describes the step by step processing of data.

1. Prerequisite: Section "Install" is successfuly executed

1. Prerequisite: Section "Creating an env file" is successfuly executed

1. Transfer data into the directory path with the following command (This has to be executed on the HPC via the alias "task conn-hpc" or any other tool). It is important that the corresponding raw data .fast5 files are with the directory named accodirng to the DATASET_NAME (no subddirectories allowed).

`cp -avr <Path to dir with Data> <$USER/WorkArea/data>`

4. Depending on the sequencing read output the raw data can be within many subdirectories and labelled by quality and barcode. In order to copy all the .fast5 files within the subdirectories into a single directory the following command can be used on the server:

`find Directory_Raw_Data_Old/ -name "*.fast5" -exec cp {} Directory_Raw_Data_New/ \;`

5. Check that necessary variables are set to run a specific script, then use the following command.

`task run-script <Name of the script>`


## Workflow Processing of Scripts
This section describes the execution of a workflow

1. Prerequisite: Section "Install" is successfuly executed

1. Prerequisite: Section "Creating an env file" is successfuly executed

4. Depending on the sequencing read output, the raw data can be in many subdirectories and labelled by quality and barcode id. In order to copy all the .fast5 files within the subdirectories into a single directory the following command can be used on the server:

`find Directory_Raw_Data_Old/ -name "*.fast5" -exec cp {} Directory_Raw_Data_New/ \;`

5. Check that necessary variables are set to run a specific script, then use the following command.

`task run-wf <Name of the workflow>`

## Explanation of the env file content
The content of the evn files is explained in the following file:

[Env File Content](https://github.com/SebastianVonRotz/POND/blob/master/env_file_content.md)

## Available scripts and programs
The available scripts and tested programs are shown below. The uper half shows the tools and displays their type of installation, version and source. The lower half shows the corresponding scripts utilizing the tools for data processing.

![Scripts_Detailed.JPG](https://github.com/SebastianVonRotz/POND/blob/master/assets/Section_5.2_POND_Scripts_Detailed.jpg)


