cp 22chr_snps_angsd_sept28_NC_053212.1.beagle.gz 22chr_snps_angsd_sept28_autosomes.beagle.gz 
gunzip 22chr_snps_angsd_sept28_autosomes.beagle.gz


for SCAFFOLD in NC_053213.1 NC_053214.1 NC_053215.1 NC_053216.1 NC_053217.1 NC_053218.1 NC_053219.1 NC_053220.1 NC_053221.1 NC_053222.1 NC_053223.1 NC_053224.1 NC_053225.1 NC_053226.1 NC_053227.1 NC_053228.1 NC_053229.1 NC_053231.1 NC_053232.1
do
	zcat 22chr_snps_angsd_sept28_${SCAFFOLD}.beagle.gz  | tail -n +2 >> 22chr_snps_angsd_sept28_autosomes.beagle
done

gzip 22chr_snps_angsd_sept28_autosomes.beagle


### Dropping dups from non-ld pruned beagle **

#To drop:
#Ind98 IR-343-C-RED_paired-nodups_22chr.bam (298 299 300)
#Ind138 M159-RED_paired-nodups_22chr.bam (418,419,420)
#Ind165 MTC30-RED_paired-nodups_22chr.bam (499 500 501)
#Ind218 RED-THA-C_paired-nodups_22chr.bam (658 659 660)
#Ind174 NTC1_paired-nodups_22chr.bam (526,527,528)
#Ind175 NTC2_paired-nodups_22chr.bam (529,530,531)
#Ind176 NTC3_paired-nodups_22chr.bam (532,533,534)

zcat 22chr_snps_angsd_sept28_autosomes.beagle.gz | cut -f  298,299,300,418,419,420,499,500,501,658,659,660,526,527,528,529,530,531,532,533,534 --complement > 22chr_snps_angsd_sept28_autosomes_nodups.beagle

gzip 22chr_snps_angsd_sept28_autosomes_nodups.beagle