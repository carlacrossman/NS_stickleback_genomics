###---Index mtDNA reference fasta---###

module load samtools/1.20
samtools faidx ../reference_genome/GCF_016920845.1_GAculeatus_UGA_version5_genomic.fna NC_041244.1 > GCF_016920845.1_GAculeatus_mtdna.fasta

###---Filtering mtDNA vcf---###

module load bcftools/1.19 vcftools/0.1.16
bcftools norm -f GCF_016920845.1_GAculeatus_mtdna.fasta stickleback_mtDNA.vcf.gz | bcftools filter -e 'FS>60.0 || SOR>4 || MQ<20 || QD<2.0' > stickleback_mtDNA_site_filtered_sept11.vcf
vcftools --vcf stickleback_mtDNA_site_filtered_sept11.vcf --out stickleback_mtDNA_all_filtered_sept11 --minDP 10 --minGQ 30 --max-missing 0.5 --recode --recode-INFO-all
bgzip stickleback_mtDNA_all_filtered_sept11.recode.vcf

tabix stickleback_mtDNA_all_filtered_sept11.recode.vcf.gz
