for ITERATOR in {1..245}
do
	SAMPLE=$(sed -n "${ITERATOR}p" ~/scratch/stickleback/sample_list)
	echo $SAMPLE
	samtools coverage -q 30 -r NC_053230.1 ../temp_mapping/${SAMPLE}_paired-nodups_22chr.bam | tail -1 > X
	samtools coverage -q 30 -r NC_053233.1 ../temp_mapping/${SAMPLE}_paired-nodups_22chr.bam | tail -1 > Y
	echo -e $SAMPLE"\t$(cat X)" >> sexing_depth
	echo -e $SAMPLE"\t$(cat Y)" >> sexing_depth
done

# Manually add word "Sample" to the beginning of header line and remove # from #rname
nano sexing_depth