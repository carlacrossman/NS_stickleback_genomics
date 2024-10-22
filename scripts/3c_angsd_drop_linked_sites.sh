#!/bin/bash
#SBATCH --job-name=ANGSD_LDpruned
#SBATCH --output=%x-%j.out
#SBATCH --account=def-pbentzen
#SBATCH --array=3-22
#SBATCH --cpus-per-task=10
#SBATCH --mem=10G
#SBATCH --time=6:00:00

BASEDIR=~/scratch/stickleback/angsd/ # Path to the base directory where output files will be written to a subdirectory named "angsd/"

REFERENCE=~/scratch/stickleback/reference_genome/GCF_016920845.1_GAculeatus_UGA_version5_genomic.fna # Path to reference genome

BAM_LIST=~/scratch/stickleback/temp_mapping/22chr_bam_list

SCAFFOLD_LENGTH=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ../angsd/scaffold_length)

SCAFFOLD=$(echo ${SCAFFOLD_LENGTH} | awk '{print $1}')

## Build base name of output files
OUTBASE=22chr_angsd_sept26_LDpruned_${SCAFFOLD}

SNP_LIST=plink_${SCAFFOLD}_site_list

angsd sites index ../angsd/${SNP_LIST}

angsd -b ${BAM_LIST} -ref $REFERENCE -out ${BASEDIR}${OUTBASE} \
    -GL 1 -doGlf 2 -doMajorMinor 1 -doMAF 1 -doPost 1 -doIBS 1 -doCounts 1 -doCov 1 -dovcf -P 10 -makeMatrix 1 -sites ../angsd/${SNP_LIST} -r ${SCAFFOLD}: \
         >& ANGSD_pruning_22chr_sept26_${SCAFFOLD}.log