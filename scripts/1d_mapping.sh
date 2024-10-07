#!/bin/bash
#SBATCH --job-name=map_stickleback
#SBATCH --output=%x-%j.out
#SBATCH --account=def-pbentzen
#SBATCH --array=21,23,30,63,64,65,82,91,96,106,119,125,126,142,147,163,170
#SBATCH --cpus-per-task=25
#SBATCH --mem=10G
#SBATCH --time=01:30:00

module load bwa/0.7.18 samtools/1.20

INPUT_DIR=~/scratch/stickleback/trimmed/trimmed

REFERENCE_GENOME=~/scratch/stickleback/reference_genome/GCF_016920845.1_GAculeatus_UGA_version5_genomic.fna

OUTPUT_DIR=~/scratch/stickleback/temp_mapping

LOG_DIR=~/scratch/stickleback/temp_mapping/logs

SAMPLE=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ~/scratch/stickleback/sample_list)

#bwa mem -M -t 28 \
#  ${REFERENCE_GENOME} \
#  ${INPUT_DIR}/${SAMPLE}_FP.fq.gz \
#  ${INPUT_DIR}/${SAMPLE}_RP.fq.gz > \
#  ${OUTPUT_DIR}/${SAMPLE}_paired.sam \
#  2> ${LOG_DIR}/${SAMPLE}-bwa_paired.err

#bwa mem -M -t 28 \
#  ${REFERENCE_GENOME} \
#  ${INPUT_DIR}/${SAMPLE}_FUP.fq.gz > \
#  ${OUTPUT_DIR}/${SAMPLE}_forward.sam \
#  2> ${LOG_DIR}/${SAMPLE}-bwa_forward.err

samtools sort -o ${OUTPUT_DIR}/${SAMPLE}_paired.bam ${OUTPUT_DIR}/${SAMPLE}_paired.sam

samtools sort -o ${OUTPUT_DIR}/${SAMPLE}_forward.bam ${OUTPUT_DIR}/${SAMPLE}_forward.sam

rm ${OUTPUT_DIR}/${SAMPLE}*.sam
