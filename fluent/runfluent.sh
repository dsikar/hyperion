#!/bin/bash
#SBATCH --job-name=fl_3ddp                 # Job name
#SBATCH --mail-type=ALL                 # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=daniel.sikar@city.ac.uk         # Where to send mail	
#SBATCH --nodes=4                                # Run on 4 nodes (each node has 48 cores)
#SBATCH --ntasks-per-node=48
#SBATCH --exclusive                              # Exclusive use of nodes
#SBATCH --mem=0                                  # Expected memory usage (0 means use all available memory)
#SBATCH --time=24:00:00                          # Time limit hrs:min:sec
#SBATCH -e outputs/runfluent%j.e
#SBATCH -o outputs/runfluent%j.o           # Standard output and error log [%j is replaced with the jobid]

#enable modules
source /opt/flight/etc/setup.sh 
# deactivate any previously activated environments
flight env deactivate
# activate gridware for this fluent job
flight env activate gridware

#remove any unwanted modules 
module purge
#Modules required
module load fluent/v211

# srun hostname -s 1 sort > hosts.$SLURM_JOB_ID
# srun hostname | sort | uniq -c | awk '{print $2 " slots=" $1}' > hosts.$SLURM_JOB_ID 
srun hostname -s > outputs/hosts.$SLURM_JOB_ID

#Command line to run task
# fluent 3ddp -pib.infinipath -mpi=intel -ssh -slurm -g -i fluent.jou

fluent 3ddp \
                 -g \
                 -mpi=intel \
                 -pib.infinipath \ 
                 -ssh \
                 -t$SLURM_NTASKS \ 
                 -cnf=outputs/hosts.$SLURM_JOB_ID \
                 -i fluent.jou > outputs/fluent_`date '+%F_%H-%M-%S'`.out
