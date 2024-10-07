#!/bin/bash
#SBATCH --job-name=mtdna-hapcaller
#SBATCH --output=%x-%j.out
#SBATCH --account=def-frasiert
#SBATCH --array=2-245%50
#SBATCH --cpus-per-task=1
#SBATCH --mem=5G
#SBATCH --time=0:15:00

module load gatk/4.4.0.0 java/17.0.6 picard/3.1.0 samtools/1.20

export JAVA_TOOL_OPTIONS="-Xmx5G"

SAMPLE=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ~/scratch/stickleback/sample_list)

REFERENCE=~/scratch/stickleback/reference_genome/GCF_016920845.1_GAculeatus_UGA_version5_genomic

java -Xmx4G -jar $EBROOTPICARD/picard.jar AddOrReplaceReadGroups \
       I=~/scratch/stickleback/temp_mapping/${SAMPLE}_paired-nodups_mtdna.bam \
       O=${SAMPLE}_paired-nodups_mtdna_rg.bam \
       RGLB=stickleback \
       RGPL=ILLUMINA \
       RGPU=stickleback \
       RGSM=${SAMPLE}

samtools index ${SAMPLE}_paired-nodups_mtdna_rg.bam

cp ${REFERENCE}* ${SLURM_TMPDIR}
cp ${SAMPLE}_paired-nodups_mtdna_rg.bam  ${SLURM_TMPDIR}
cp ${SAMPLE}_paired-nodups_mtdna_rg.bam.bai ${SLURM_TMPDIR}
cd ${SLURM_TMPDIR}

gatk --java-options "-Xmx4g" HaplotypeCaller \
  -R GCF_016920845.1_GAculeatus_UGA_version5_genomic.fna \
  -I ${SAMPLE}_paired-nodups_mtdna_rg.bam \
  -O ${SAMPLE}-mtDNA.g.vcf.gz \
  -ERC GVCF \
  -ploidy 1 \
  -L NC_041244.1 \
  2> ${SAMPLE}-mtDNA-hapcall-gvcf.out

cp ${SAMPLE}-mtDNA* ${SLURM_SUBMIT_DIR}
