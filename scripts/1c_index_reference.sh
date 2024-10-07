#!/bin/bash
#SBATCH --time=02:00:00
#SBATCH --account=def-pbentzen
#SBATCH --job-name=index_reference
#SBATCH --mem-per-cpu=8000M
#SBATCH --cpus-per-task=8

module load bwa/0.7.18 samtools/1.20

bwa index GCF_016920845.1_GAculeatus_UGA_version5_genomic.fna

samtools faidx GCF_016920845.1_GAculeatus_UGA_version5_genomic.fna

samtools dict GCF_016920845.1_GAculeatus_UGA_version5_genomic.fna -o GCF_016920845.1_GAculeatus_UGA_version5_genomic.dict
