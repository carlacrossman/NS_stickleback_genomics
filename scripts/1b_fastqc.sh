#!/bin/bash
#SBATCH --job-name=fastQC_post
#SBATCH --output=%x-%j.out
#SBATCH --account=def-pbentzen
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=4:00:00

module load fastqc

for ITERATOR in {90..100}
do
 export JAVA_TOOL_OPTIONS="-Xmx7G"
 SAMPLE=$(sed -n "${ITERATOR}p" ~/scratch/stickleback/sample_list)
 fastqc -o fastQC/ ${SAMPLE}_FP.fq.gz
 fastqc -o fastQC/ ${SAMPLE}_RP.fq.gz
 fastqc -o fastQC/ ${SAMPLE}_FUP.fq.gz
done
