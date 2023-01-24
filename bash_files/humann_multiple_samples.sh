#!/bin/bash

#SBATCH --partition=cpu16
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=0-10:00:00
#SBATCH --mem=35G
#SBATCH --error=humann_run.%J.err
#SBATCH --output=humann_run.%J.out
#SBATCH --array=0-9 # job array index

names=($(cat /home/hena.ramay/workshop2023/metaphlan/metaphlan_multiple_samples/names.txt))

SAMPLE=${names[${SLURM_ARRAY_TASK_ID}]}
echo ${SAMPLE}

date

 humann --input /home/hena.ramay/workshop2023/kneaddata_multiple_samples/kneaddata_output_${SAMPLE}/${SAMPLE}.fastq --output ${SAMPLE} --threads 6 \
	--protein-database /work/TALC/wkshp-2022-12-12/databases/humann3.1/uniref \
	--nucleotide-database /work/TALC/wkshp-2022-12-12/databases/humann3.1/chocophlan/ \
	--metaphlan-options=" --index mpa_vJan21_CHOCOPhlAnSGB_202103 --bowtie2db /work/TALC/wkshp-2022-12-12/databases/metaphlan4/"

date
