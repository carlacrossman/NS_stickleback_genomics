#!/bin/bash
#SBATCH --job-name=subset_bams
#SBATCH --output=%x-%j.out
#SBATCH --account=def-pbentzen
#SBATCH --cpus-per-task=5
#SBATCH --mem=8G
#SBATCH --time=12:00:00

module load samtools/1.20

for ITERATOR in {44..50}
do
 SAMPLE=$(sed -n "${ITERATOR}p" ~/scratch/stickleback/sample_list)
 samtools view -@ 4 -o ${SAMPLE}_paired-nodups_mtdna.bam ${SAMPLE}_paired-nodups.bam NC_041244.1
 samtools index ${SAMPLE}_paired-nodups_mtdna.bam
 samtools view -@ 4 --region-file ../stickleback_scaffold_list -o ${SAMPLE}_paired-nodups_22chr.bam ${SAMPLE}_paired-nodups.bam
 samtools index ${SAMPLE}_paired-nodups_22chr.bam
done
