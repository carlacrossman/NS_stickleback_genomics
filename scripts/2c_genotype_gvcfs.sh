#!/bin/bash
#SBATCH --job-name=genotype_gvcf
#SBATCH --output=%x-%j.out
#SBATCH --account=def-pbentzen
#SBATCH --cpus-per-task=1
#SBATCH --mem=15G
#SBATCH --time=4:00:00

module load gatk/4.4.0.0 java/17.0.6

export JAVA_TOOL_OPTIONS="-Xmx14G"

gatk --java-options "-Xmx14g" GenotypeGVCFs \
   -R ~/scratch/stickleback/reference_genome/GCF_016920845.1_GAculeatus_UGA_version5_genomic.fna \
   -V gendb://genomicsDB/ \
   -O ~/scratch/stickleback/mtDNA_vcf/stickleback_mtDNA.vcf.gz \
   2> ~/scratch/stickleback/mtDNA_vcf/mtdna-gvcf.out
