#!/bin/bash
#SBATCH --job-name=ngsadmix_1-6
#SBATCH --output=%x-%j.out
#SBATCH --account=def-pbentzen
#SBATCH --array=1-10
#SBATCH --cpus-per-task=10
#SBATCH --mem=40G
#SBATCH --time=12:00:00

module load angsd

for K in {1..6}; do
        echo ${K}
        NGSadmix \
        -likes ../angsd/22chr_angsd_sept26_LDpruned_autosomes_nodups.beagle.gz \
        -K ${K} \
        -P 10 \
        -o ngsadmix_angsd_sept26_LDpruned_autosomes_k${K}_${SLURM_ARRAY_TASK_ID} \
        -minMaf 0.05
done