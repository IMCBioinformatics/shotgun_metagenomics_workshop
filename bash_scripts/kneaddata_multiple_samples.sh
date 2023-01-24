#!/bin/bash

#SBATCH --partition=cpu16
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=0-05:00:00
#SBATCH --mem=35G
#SBATCH --error=kneaddata_multi_run.%J.err
#SBATCH --output=kneaddata_multi_run.%J.out
#SBATCH --array=0-10 # job array index

ls /work/TALC/wkshp-2022-12-12/project_data/ | grep R1_001.fastq | sed 's/_R1_001.fastq//' > names.txt

names=($(cat names.txt))
SAMPLE=${names[${SLURM_ARRAY_TASK_ID}]}
echo ${SAMPLE}
 
kneaddata -i /work/TALC/wkshp-2022-12-12/project_data/${SAMPLE}_R1_001.fastq -i /work/TALC/wkshp-2022-12-12/project_data/${SAMPLE}_R2_001.fastq \
-db /work/TALC/wkshp-2022-12-12/databases/bowtie2/homo_sapiens/ -db /work/TALC/wkshp-2022-12-12/databases/bowtie2/phix/ --output kneaddata_output_${SAMPLE} \
--trimmomatic /work/TALC/wkshp-2022-12-12/Trimmomatic-0.39/  --run-fastqc-end --run-fastqc-start -t 12 --output-prefix  ${SAMPLE} --cat-final-output

kneaddata_read_count_table --input kneaddata_output_${SAMPLE} --output kneaddata_output/kneaddata_read_counts_${SAMPLE}.txt
