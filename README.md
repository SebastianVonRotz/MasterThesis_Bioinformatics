# MA Bioinformatics Workflows


## Install

1. Clone this project.  

`git clone https://...` 

1. Setup SSH-Keypair. `

`ssh-keygen -t rsa`


1.  Upload public SSH key to `head.hpc.zhaw.ch`.

`ssh-copy-id demo@198.51.100.0`

1. Create an alias for task script in your `.bashrc/.zshrc` (simply paste the alias command in the file at the bottom).

` alias task='./task' `


## Usage

Load the env paths
`task load-env`

Connect to the hpc server
`task conn-hpc`

Upload the actual env file and a script
`task upload-script <script_name>`

Run a script defined in the scripts directory
`task run-hpc-script <workflow_directory> <script_name>`

Check the status of the hpc and get running jobs of others
`task hpc-status`

Check the status of a specific job
`task job-status`

Get a list of available nodes
`task node-status`

Cancel a job
`task cancel-jobs`


## Helpers

Convert dos file to unix file.  
`dos2unix <filename>`