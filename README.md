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

## User Setup Overview

![Image of the overview](https://github.zhaw.ch/voro/MA-Bioinformatics-Workflows/blob/master/images/user_setup_overview.JPG)


## Running Scripts on the HPC




## General

Check if task alias is created or loaded

`task start`

## Interact with hpc and jobs

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

## Executing scripts
Load the env paths (shows other functions the REMOTEPATH)

`task load-env`

Upload the actual env file and a script

`task upload-script <script_name> <env file>`

Run a script defined in the scripts directory

`task run-hpc-script <script_name> <env file>`

Run a workflow (eg. wp_02)

`task run-workflow <workflow_Name>`

## Helpers

Convert dos file to unix file.  

`dos2unix <filename>`


