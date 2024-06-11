#!/bin/bash
#SBATCH --job-name=test
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=32
#SBATCH --output=<root_path>/running_first_sim/test_run.out
#SBATCH --error<root_path>/running_first_sim/test_run.err
#SBATCH --partition=hbm-short-96core
#SBATCH -t 4:00:00

colasolver=<FML_path>/FML/FML/COLASolver/nbody
param_file=<root_path>parameter_file.lua
module purge > /dev/null 2>&1
module load slurm
source <miniconda_path>/miniconda/etc/profile.d/conda.sh
echo Running on host `hostname`
echo Time is `date`
echo Directory is `pwd`
echo Slurm job NAME is $SLURM_JOB_NAME
echo Slurm job ID is $SLURM_JOBID
echo Number of task is $SLURM_NTASKS
echo Number of cpus per task is $SLURM_CPUS_PER_TASK

cd $SLURM_SUBMIT_DIR
conda activate cola
source start_cola

export OMP_PROC_BIND=close
if [ -n "$SLURM_CPUS_PER_TASK" ]; then
  export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
else
  export OMP_NUM_THREADS=1
fi


mpirun -n ${SLURM_NTASKS} --report-bindings --mca btl tcp,self --bind-to core --map-by numa:pe=${OMP_NUM_THREADS} $colasolver $param_file
