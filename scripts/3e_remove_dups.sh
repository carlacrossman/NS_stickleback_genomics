#Ind98 IR-343-C-RED_paired-nodups_22chr.bam (298 299 300)
#Ind138 M159-RED_paired-nodups_22chr.bam (418,419,420)
#Ind165 MTC30-RED_paired-nodups_22chr.bam (499 500 501)
#Ind218 RED-THA-C_paired-nodups_22chr.bam (658 659 660)
#Ind174 NTC1_paired-nodups_22chr.bam (526,527,528)
#Ind175 NTC2_paired-nodups_22chr.bam (529,530,531)
#Ind176 NTC3_paired-nodups_22chr.bam (532,533,534)


zcat 22chr_angsd_sept26_LDpruned_autosomes.beagle.gz | cut -f  298,299,300,418,419,420,499,500,501,658,659,660,526,527,528,529,530,531,532,533,534 --complement > 22chr_angsd_sept26_LDpruned_autosomes_nodups.beagle

gzip 22chr_angsd_sept26_LDpruned_autosomes_nodups.beagle