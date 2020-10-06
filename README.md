# MA Bioinformatics Workflows


## Install

1. Clone this project.  
`git clone https://...` 

1. Setup SSH-Keypair.

1.  Upload public SSH key to `head.hpc.zhaw.ch`.

1. Create an alias for task script in your `.bashrc/.zshrc`.  
`alias task='./task'`


## Usage

Load the env paths
`task load-env`

Upload the actual env file and a script
`task upload-script <script_name>`

Run a script defined in the scripts directory
`task run-hpc-script <script_name>`

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
`dos2unix filename`