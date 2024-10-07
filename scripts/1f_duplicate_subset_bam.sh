#!/bin/bash
#SBATCH --job-name=dup_subset_stickleback
#SBATCH --output=%x-%j.out
#SBATCH --account=def-pbentzen
#SBATCH --array=2-245%40
#SBATCH --cpus-per-task=2
#SBATCH --mem=10G
#SBATCH --time=00:30:00

module load StdEnv/2020 gcc/9.3.0 java/13.0.2 gatk/4.1.8.1 picard/2.26.3 samtools/1.20

SAMPLE=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ~/scratch/stickleback/sample_list)

export JAVA_TOOL_OPTIONS="-Xmx9g"

java -Xmx9G -jar $EBROOTPICARD/picard.jar MarkDuplicates \
  --REMOVE_DUPLICATES true --CREATE_INDEX true \
  --INPUT ${SAMPLE}_paired.bam \
  --OUTPUT ${SAMPLE}_paired-nodups.bam \
  --TMP_DIR ${SLURM_TMPDIR} \
  --METRICS_FILE ${SAMPLE}_paired-nodups.metrics

samtools view -o ${SAMPLE}_paired-nodups_mtdna.bam ${SAMPLE}_paired-nodups.bam NC_041244.1
samtools index ${SAMPLE}_paired-nodups_mtdna.bam

samtools view --region-file ../stickleback_scaffold_list -o ${SAMPLE}_paired-nodups_22chr.bam ${SAMPLE}_paired-nodups.bam
samtools index ${SAMPLE}_paired-nodups_22chr.bam
