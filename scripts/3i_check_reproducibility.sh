#Repeat the following for all duplicates

module load bcftools/1.19

bcftools view -s M159-RED_paired-nodups_22chr.bam,M159_paired-nodups_22chr.bam 22chr_snps_angsd_sept28.vcf.gz | bcftools view -e 'GT[*] = "mis"' | bcftools gtcheck -E 0 > M159_repeatability