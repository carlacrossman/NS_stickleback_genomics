#!/bin/bash
#SBATCH --job-name=ANGSD_by_scaffold
#SBATCH --output=%x-%j.out
#SBATCH --account=def-pbentzen
#SBATCH --array=1-22
#SBATCH --cpus-per-task=10
#SBATCH --mem=10G
#SBATCH --time=6:00:00

module load angsd plink

BASEDIR=~/scratch/stickleback/angsd/ # Path to the base directory where output files will be written to a subdirectory named "angsd/"

REFERENCE=~/scratch/stickleback/reference_genome/GCF_016920845.1_GAculeatus_UGA_version5_genomic.fna # Path to reference genome

BAM_LIST=~/scratch/stickleback/temp_mapping/22chr_bam_list

SCAFFOLD_LENGTH=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ../angsd/scaffold_length)

SCAFFOLD=$(echo ${SCAFFOLD_LENGTH} | awk '{print $1}')

## Build base name of output files
OUTBASE=22chr_snps_angsd_sept28_${SCAFFOLD}

## Call SNPs
angsd -b ${BAM_LIST} -ref $REFERENCE -out ${BASEDIR}${OUTBASE} \
        -doBcf 1 -GL 1 -doGlf 2 -dopost 1 -doPlink 2 -doMaf 1 -doMajorMinor 1 -doCounts 1 -doDepth 1 -maxDepth 10000 -dumpCounts 1 -doIBS 1 -makematrix 1 -doGeno -4 -doCov 1 \
        -setMinDepth 80 -setMaxDepth 1680 -minMaf 0.05 \
        -minQ 20 -minMapQ 20 -SNP_pval 1e-6 -r ${SCAFFOLD}: \
        -P 10 -remove_bads 1 -only_proper_pairs 1 -C 50 >& ANGSD_snp_calling_22chr_sept28_${SCAFFOLD}.log