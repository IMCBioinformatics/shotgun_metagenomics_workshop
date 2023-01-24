#!/bin/bash

#SBATCH --partition=cpu16
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=0-05:00:00
#SBATCH --mem=35G
#SBATCH --error=humann_run.%J.err
#SBATCH --output=humann_run.%J.out

 humann --input /home/hena.ramay/workshop2023/kneaddata_output/S1.fastq --output S1 --threads 6 \
	--protein-database /work/TALC/wkshp-2022-12-12/databases/humann3.1/uniref \
	--nucleotide-database /work/TALC/wkshp-2022-12-12/databases/humann3.1/chocophlan/ \
	--metaphlan-options=" --index mpa_vJan21_CHOCOPhlAnSGB_202103 --bowtie2db /work/TALC/wkshp-2022-12-12/databases/metaphlan4/"



