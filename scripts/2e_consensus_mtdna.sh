#!/bin/bash
#SBATCH --job-name=consensus_mtdna
#SBATCH --output=%x-%j.out
#SBATCH --account=def-pbentzen
#SBATCH --cpus-per-task=1
#SBATCH --mem=10G
#SBATCH --time=4:00:00



for ITERATOR in {1..245}
do
	SAMPLE=$(sed -n "${ITERATOR}p" ~/scratch/stickleback/sample_list)
	bcftools consensus -f GCF_016920845.1_GAculeatus_mtdna.fasta --haplotype I --missing N -s ${SAMPLE} stickleback_mtDNA_all_filtered_sept11.recode.vcf.gz >> consensus_stickleback_mtDNA_sept11.fa
	sed -i "s,NC_041244.1,${SAMPLE}," consensus_stickleback_mtDNA_sept11.fa
done
