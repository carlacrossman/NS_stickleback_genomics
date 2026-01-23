### --- 3a Running ANGSD--- ###

# Intital run through to identify the variant sites and generate beagle files
# based on likelihood to estimate reproducibility and to generate ML trees
# 
# The input files are the generated bam files and a list of the bam files to use
# This list includes duplicate samples and excludes two samples where mean depth across 22-chromosomes < 1
#
# ANGSD version 0.941-26-g6b5d906

```{bash}
ANGSD=~/Documents/PostDoc/programs/angsd/angsd
REFERENCE=~/Documents/PostDoc/Stickleback/reference_genome/GCF_016920845.1_GAculeatus_UGA_version5_genomic.fna

for SCAFFOLD in NC_053212.1 NC_053213.1 NC_053214.1 NC_053215.1 NC_053216.1 NC_053217.1 NC_053218.1 NC_053219.1 NC_053220.1 NC_053221.1 NC_053222.1 NC_053223.1 NC_053224.1 NC_053225.1 NC_053226.1 NC_053227.1 NC_053228.1 NC_053229.1 NC_053230.1 NC_053231.1 NC_053232.1 NC_053233.1; do
  OUT=~/Documents/PostDoc/Stickleback/angsd/22chr_snps_angsd_dec1_${SCAFFOLD}
  echo ${SCAFFOLD}
  $ANGSD -b  bam_list_dec1 -ref $REFERENCE -out ${OUT} \
        -GL 1 -doGlf 2 -doMaf 1 -doMajorMinor 1 -doCounts 1 \
        -setMinDepth 80 -setMaxDepth 1680 -r ${SCAFFOLD}: \
        -minQ 20 -minMapQ 20 -SNP_pval 1e-6 \
        -P 6 -remove_bads 1 -trim 0 -baq 1 -uniqueOnly 1 \
        -only_proper_pairs 1 -C 50 >& ${OUT}.log
done


# Navigate to output directory after checking log files

cp 22chr_snps_angsd_dec1_NC_053212.1.beagle.gz merged_dec1_angsd1.beagle.gz
gunzip merged_dec1_angsd1.beagle.gz

for SCAFFOLD in NC_053213.1 NC_053214.1 NC_053215.1 NC_053216.1 NC_053217.1 NC_053218.1 NC_053219.1 NC_053220.1 NC_053221.1 NC_053222.1 NC_053223.1 NC_053224.1 NC_053225.1 NC_053226.1 NC_053227.1 NC_053228.1 NC_053229.1 NC_053231.1 NC_053232.1
do
  zcat 22chr_snps_angsd_dec1_${SCAFFOLD}.beagle.gz | tail -n +2 >> merged_dec1_angsd1.beagle
done
```