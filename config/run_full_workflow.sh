#!/bin/bash
#SBATCH --partition=componc_cpu
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --time=48:00:00
#SBATCH --mem=8GB
#SBATCH --job-name=PG3
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=preskaa@mskcc.org
#SBATCH --output=slurm%j_pg_snkmk.out

### example slurm submission script ###

## set directories
tag=APS010.1
pipeline_dir=$HOME/proteomegenerator-smk
config_yaml=config/config.yml
profile_yaml=${pipeline_dir}/workflow/profiles/
snakefile=${pipeline_dir}/workflow/Snakefile
## switch to the right conda environment
source /home/preskaa/miniforge3/bin/activate snakemake

### run the pipeline
echo "Current working directory: $(pwd)"
echo "Snakefile path: ${snakefile}"

# this will run the process, for example you could switch the below to a python command:
# python script.py
cd ${pipeline_dir}

## if using conda, include flag:
## --conda-prefix /data1/shahs3/users/preskaa/conda
snakemake \
  --snakefile ${snakefile} \
  --profile ${profile_yaml} \
  --configfile ${config_yaml}\
  --conda-prefix /data1/shahs3/users/preskaa/conda \
  --singularity-prefix /data1/shahs3/users/preskaa/singularity \
  --singularity-args "--bind /data1/shahs3" \
  --dry-run