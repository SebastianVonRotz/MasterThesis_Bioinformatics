# MA Bioinformatics Workflows

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

    `REMOTE_PATH= <Path_to_User>` (example: REMOTE_PATH=/cfs/earth/scratch/$User/work_area/scripts/) 

1. Check the if the task-commands are setup by running

    `task start`

1. Create the directories at the remote path

    `task init`

## Overview of the user setup
The task-commands simplify the interaction with a high performance computing envrironment run on the Slurm Workload Manager. This setup is designed and tested to run on the hardware and software envrionment at ZHAW, altought the general concept and scripts should be transferable to other systems. The following picture depicts an overview of the user interaction.
![HPC_Server_Interaction](https://github.zhaw.ch/voro/MA-Bioinformatics-Workflows/blob/master/assets/HPC_Server_Interaction.JPG)

## Overview of processing scripts on the HPC
Scripts process and transform data in a sequential order. This sequenced processing of the data is depicted in the following picture. Depending on the script certain processing steps need to be fullfilled in order to get the correct inpurt for the current script.

![Scripts_Processing_Overview](https://github.zhaw.ch/voro/MA-Bioinformatics-Workflows/blob/master/assets/Scripts_Processing_Overview.JPG)

## Step by Step Processing of Scripts
1. Add the following to the env file:


## Workflow Processing of Scripts


## Task Commands
### General

Check if task alias is created or loaded

`task start`

##### Interact with hpc and jobs

Connect to the hpc server

`task conn-hpc`

Check the status of the hpc and get running jobs of others

`task hpc-status`

Check the status of a specific job

`task job-status <Job ID>`

Get a list of available nodes

`task node-status`

Cancel a job

`task cancel-jobs`

Get files or directory from hpc server (stored in data_temp directory)

`dl-data <file/directory path>`

##### Executing scripts
Load the env paths (shows other functions the REMOTEPATH)

`task load-env`

Upload the actual env file and a script

`task upload-script <script_name> <env file>`

Run a script defined in the scripts directory

`task run-hpc-script <script_name> <env file>`

Run a workflow (eg. wp_02)

`task run-workflow <workflow_Name>`

##### Helpers

Convert dos file to unix file.  

`dos2unix <filename>`


