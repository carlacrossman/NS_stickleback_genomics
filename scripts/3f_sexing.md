### --- 3f Sexing --- ###

# This script uses samtools coverage to calculate the depth for the X (NC_053230.1) and Y (NC_053233.1) chromosomes
# These results are plotted in R and used to confirm sex of each individual

```{bash}
module load samtools/1.20

for ITERATOR in {1..245}
do
	SAMPLE=$(sed -n "${ITERATOR}p" ~/scratch/stickleback/sample_list)
	echo $SAMPLE
	samtools coverage -r NC_053230.1 ../temp_mapping/${SAMPLE}_paired-nodups_22chr.bam | tail -1 > X
	samtools coverage -r NC_053233.1 ../temp_mapping/${SAMPLE}_paired-nodups_22chr.bam | tail -1 > Y
	echo -e $SAMPLE"\t$(cat X)" >> sexing_depth
	echo -e $SAMPLE"\t$(cat Y)" >> sexing_depth
done

# Manually add word "Sample" to the beginning of header line and remove # from #rname
nano sexing_depth
```
