#!/bin/bash

#SBATCH --partition=cpu16
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=0-05:00:00
#SBATCH --mem=35G
#SBATCH --error=metaphlan_run.%J.err
#SBATCH --output=metaphlan_run.%J.out
#SBATCH --array=0-10 # job array index

names=($(cat names.txt))

SAMPLE=${names[${SLURM_ARRAY_TASK_ID}]}
echo ${SAMPLE}

mkdir  output_SGB
mkdir output_GTDB
mkdir output_bowtie2

echo "metaphlan /home/hena.ramay/workshop2023/kneaddata_output_${SAMPLE}/${SAMPLE}.fastq  --bowtie2db /work/TALC/wkshp-2022-12-12/databases/metaphlan4 --bowtie2out output_bowtie2/${SAMPLE}.bowtie2.bz2 --nproc 5 --input_type fastq -t rel_ab_w_read_stats --unclassified_estimation -o output_SGB/${SAMPLE}_metaphlan.txt "


metaphlan /home/hena.ramay/workshop2023/kneaddata_multiple_samples/kneaddata_output_${SAMPLE}/${SAMPLE}.fastq  --bowtie2db /work/TALC/wkshp-2022-12-12/databases/metaphlan4 --bowtie2out output_bowtie2/${SAMPLE}.bowtie2.bz2  \
	--nproc 5 --input_type fastq -t rel_ab_w_read_stats --unclassified_estimation -o output_SGB/${SAMPLE}_metaphlan.txt 

sgb_to_gtdb_profile.py -i output_SGB/${SAMPLE}_metaphlan.txt -o output_GTDB/${SAMPLE}_metaphlan_output_gtdb.txt 

wait

