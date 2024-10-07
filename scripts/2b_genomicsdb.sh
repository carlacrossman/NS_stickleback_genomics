#!/bin/bash
#SBATCH --job-name=genomicsdb
#SBATCH --output=%x-%j.out
#SBATCH --account=def-frasiert
#SBATCH --cpus-per-task=6
#SBATCH --mem=25G
#SBATCH --time=1:00:00

module load gatk/4.4.0.0 java/17.0.6

export JAVA_TOOL_OPTIONS="-Xmx20G"

gatk --java-options "-Xmx20g" GenomicsDBImport \
    --genomicsdb-workspace-path ~/scratch/stickleback/genomicsDB \
    -L NC_041244.1 \
    --sample-name-map mtdna_sample_list \
    --tmp-dir ${SLURM_TMPDIR} \
    --reader-threads 5
