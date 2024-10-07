TRIM=../programs/Trimmomatic-0.39/Trimmomatic-0.39
HD=../../../../../../d/Stickleback_Sequence_Data/00_fastq

for ITERATOR in {4..245}
do
 SAMPLE=$(sed -n "${ITERATOR}p" ../../../../../../d/Stickleback_Sequence_Data/00_fastq/sample_names)
 java -Xmx8G -jar ${TRIM}/trimmomatic-0.39.jar PE -threads 4 -phred33 \
	${HD}/${SAMPLE}_R1_001.fastq.gz \
	${HD}/${SAMPLE}_R2_001.fastq.gz \
	${HD}/${SAMPLE}_FP.fq.gz \
	${HD}/${SAMPLE}_FUP.fq.gz \
	${HD}/${SAMPLE}_RP.fq.gz \
	${HD}/${SAMPLE}_RUP.fq.gz \
	ILLUMINACLIP:${TRIM}/adapters/adapters.fa:2:30:15 LEADING:20 SLIDINGWINDOW:5:20 \
    AVGQUAL:30 MINLEN:36 2> ${SAMPLE}.trim.out
done

