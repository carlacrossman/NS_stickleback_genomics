### --- 3h Preparing Outgroup files --- ###

# I am using two marine three-spined stickleback from British Columbia as outgroup samples
# This early processing follows the same pipeline as for the main dataset
# These data were downloaded from NCBI (Sample name / Biosample / SRA)
# Ran_M5 / SAMEA4385629 / ERS1297078
# Kob_M28 / SAME4385623 / ERS1297072

```{bash}
module load trimmomatic/0.39 bwa/0.7.18 samtools/1.20

REFERENCE_GENOME=~/scratch/outgroup/reference_genome/GCF_016920845.1_GAculeatus_UGA_version5_genomic.fna
OUTPUT_DIR=~/scratch/outgroup

java -Xmx7G -jar $EBROOTTRIMMOMATIC/trimmomatic-0.39.jar PE -threads 4 -phred33 \
  ERR1599914_1.fastq \
  ERR1599914_2.fastq \
  Ran_M5_FP.fq.gz \
  Ran_M5_FUP.fq.gz \
  Ran_M5_RP.fq.gz \
  Ran_M5_RUP.fq.gz \
  ILLUMINACLIP:TruSeq3-PE.fa:2:30:15 LEADING:20 SLIDINGWINDOW:5:20 \
    AVGQUAL:30 MINLEN:36 2> Ran_M5.trim.out

java -Xmx7G -jar $EBROOTTRIMMOMATIC/trimmomatic-0.39.jar PE -threads 4 -phred33 \
  ERR1599905_1.fastq \
  ERR1599905_2.fastq \
  Kob_M28_FP.fq.gz \
  Kob_M28_FUP.fq.gz \
  Kob_M28_RP.fq.gz \
  Kob_M28_RUP.fq.gz \
  ILLUMINACLIP:TruSeq3-PE.fa:2:30:15 LEADING:20 SLIDINGWINDOW:5:20 \
    AVGQUAL:30 MINLEN:36 2> Kob_M28.trim.out

bwa mem -M -t 20 \
  ${REFERENCE_GENOME} \
  Kob_M28_FP.fq.gz \
  Kob_M28_RP.fq.gz > \
  ${OUTPUT_DIR}/Kob_M28_paired.sam \
  2> Kob_M28-bwa_paired.err

samtools sort -o ${OUTPUT_DIR}/Kob_M28_paired.bam ${OUTPUT_DIR}/Kob_M28_paired.sam

cd ../ERR1599914

bwa mem -M -t 20 \
  ${REFERENCE_GENOME} \
  Ran_M5_FP.fq.gz \
  Ran_M5_RP.fq.gz > \
  ${OUTPUT_DIR}/Ran_M5_paired.sam \
  2> Ran_M5-bwa_paired.err

samtools sort -o ${OUTPUT_DIR}/Ran_M5_paired.bam ${OUTPUT_DIR}/Ran_M5_paired.sam

rm ${OUTPUT_DIR}/Kob_M28_paired*.sam
rm ${OUTPUT_DIR}/Ran_M5_paired*.sam


for SAMPLE in Kob_M28 Ran_M5; do
java -Xmx7G -jar $EBROOTPICARD/picard.jar MarkDuplicates \
  --REMOVE_DUPLICATES true --CREATE_INDEX true \
  --INPUT ${SAMPLE}_paired.bam \
  --OUTPUT ${SAMPLE}_paired-nodups.bam \
  --METRICS_FILE ${SAMPLE}_paired-nodups.metrics

  samtools view -o ${SAMPLE}_paired-nodups_mtdna.bam ${SAMPLE}_paired-nodups.bam NC_041244.1
  samtools index ${SAMPLE}_paired-nodups_mtdna.bam

  samtools view --region-file stickleback_scaffold_list -o ${SAMPLE}_paired-nodups_22chr.bam ${SAMPLE}_paired-nodups.bam 
  samtools index ${SAMPLE}_paired-nodups_22chr.bam
done
```
