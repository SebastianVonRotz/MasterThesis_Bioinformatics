Command {Argument}|Desription
-------------------------------|---------------------------------------------------------
init | Creates project directories at the specified REMOTE_PATH
list-scripts | Returns a List of available scripts and workflows
run-script {Script Name}| Execute a script based on name argument
run-workflow {Workflow Name}| Exceute a workflow base on the name argument
conn-hpc | Connect to the head node on the HPC
load-env | Export the variables of the env file
hpc-status | Get an overview the current jobs running on the HPC
job-status {Job ID} | Get overview stats on a job based on its id argument
node-status | Get an overview of the status of the available nodes on the HPC
cancel-job {Job ID} | Cancel a job based on its id argument 
dl-data {REMOTE_PATH/Path_to_data} | Dowload data based on a path into the local temp_data directory

