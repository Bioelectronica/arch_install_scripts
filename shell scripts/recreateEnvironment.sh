echo -n "Enter the environment name:"
read envName
conda env create -n ${envName} -f environment.yml
