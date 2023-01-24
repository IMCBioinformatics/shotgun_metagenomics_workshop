#!/bin/bash

#SBATCH --partition=cpu16
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=0-05:00:00
#SBATCH --mem=35G
#SBATCH --error=metaphlan_run.%J.err
#SBATCH --output=metaphlan_run.%J.out


metaphlan /home/hena.ramay/workshop2023/kneaddata_output/S1.fastq  \
	--bowtie2db /work/TALC/wkshp-2022-12-12/databases/metaphlan4 \
	--bowtie2out S1.bowtie2.bz2 --nproc 5 --input_type fastq \
	-t rel_ab_w_read_stats --unclassified_estimation -o S1_metagenome.txt ;

#sgb_to_gtdb_profile.py -i S1_metagenome.txt -o metaphlan_output_gtdb.txt 

#wait

