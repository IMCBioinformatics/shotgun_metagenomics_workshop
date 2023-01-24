#!/bin/bash

#SBATCH --partition=cpu16
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=0-05:00:00
#SBATCH --mem=35G
#SBATCH --error=kneaddata_run.%J.err
#SBATCH --output=kneaddata_run.%J.out

kneaddata -i /work/TALC/wkshp-2022-12-12/project_data/S1_R1_001.fastq -i /work/TALC/wkshp-2022-12-12/project_data/S1_R2_001.fastq \
-db /work/TALC/wkshp-2022-12-12/databases/bowtie2/homo_sapiens/ -db /work/TALC/wkshp-2022-12-12/databases/bowtie2/phix/ --output kneaddata_output \
--trimmomatic /work/TALC/wkshp-2022-12-12/Trimmomatic-0.39/  --run-fastqc-end --run-fastqc-start -t 12 --output-prefix  S1 --cat-final-output

kneaddata_read_count_table --input kneaddata_output --output kneaddata_output/kneaddata_read_counts.txt
