### --- 3c Running ANGSD on pruned sites --- ###

# 
# This is the second running of ANGSD that only runs on unlinked sites and does not include redundant/duplicate samples 
# The genotype likelihood fiels generated here will be used as input for PCAngsd and ngsADMIXTURE
#
# ANGSD version 0.941-26-g6b5d906

```{bash}
ANGSD=~/Documents/PostDoc/programs/angsd/angsd
REFERENCE=~/Documents/PostDoc/Stickleback/reference_genome/GCF_016920845.1_GAculeatus_UGA_version5_genomic.fna

for SCAFFOLD in NC_053212.1 NC_053213.1 NC_053214.1 NC_053215.1 NC_053216.1 NC_053217.1 ; do
  OUT=~/Documents/PostDoc/Stickleback/angsd/pruned/22chr_angsd_dec2_LDpruned_nodup_${SCAFFOLD}
  echo ${SCAFFOLD}
  SNP_LIST=~/Documents/PostDoc/Stickleback/angsd/ngsLD_out/LDpruned_snps_${SCAFFOLD}.list

  $ANGSD sites index ${SNP_LIST}
  $ANGSD -b  bam_list_dec_nodup -ref ${REFERENCE} -out ${OUT} \
        -GL 1 -doGlf 2 -doMaf 1 -doMajorMinor 1 -doCounts 1 \
        -setMinDepth 80 -setMaxDepth 1680 -r ${SCAFFOLD}: \
        -minQ 20 -minMapQ 20 -SNP_pval 1e-6 \
        -P 5 -remove_bads 1 -trim 0 -baq 1 -uniqueOnly 1 \
        -only_proper_pairs 1 -C 50 -sites ${SNP_LIST} >& ${OUT}.log
done

ANGSD=~/Documents/PostDoc/programs/angsd/angsd
REFERENCE=~/Documents/PostDoc/Stickleback/reference_genome/GCF_016920845.1_GAculeatus_UGA_version5_genomic.fna

for SCAFFOLD in NC_053218.1 NC_053219.1 NC_053220.1 NC_053221.1; do
  OUT=~/Documents/PostDoc/Stickleback/angsd/pruned/22chr_angsd_dec2_LDpruned_nodup_${SCAFFOLD}
  echo ${SCAFFOLD}
  SNP_LIST=~/Documents/PostDoc/Stickleback/angsd/ngsLD_out/LDpruned_snps_${SCAFFOLD}.list

  $ANGSD sites index ${SNP_LIST}
  $ANGSD -b  bam_list_dec_nodup -ref ${REFERENCE} -out ${OUT} \
        -GL 1 -doGlf 2 -doMaf 1 -doMajorMinor 1 -doCounts 1 \
        -setMinDepth 80 -setMaxDepth 1680 -r ${SCAFFOLD}: \
        -minQ 20 -minMapQ 20 -SNP_pval 1e-6 \
        -P 5 -remove_bads 1 -trim 0 -baq 1 -uniqueOnly 1 \
        -only_proper_pairs 1 -C 50 -sites ${SNP_LIST} >& ${OUT}.log
done

ANGSD=~/Documents/PostDoc/programs/angsd/angsd
REFERENCE=~/Documents/PostDoc/Stickleback/reference_genome/GCF_016920845.1_GAculeatus_UGA_version5_genomic.fna

for SCAFFOLD in NC_053222.1 NC_053223.1 NC_053224.1 NC_053225.1; do
  OUT=~/Documents/PostDoc/Stickleback/angsd/pruned/22chr_angsd_dec2_LDpruned_nodup_${SCAFFOLD}
  echo ${SCAFFOLD}
  SNP_LIST=~/Documents/PostDoc/Stickleback/angsd/ngsLD_out/LDpruned_snps_${SCAFFOLD}.list

  $ANGSD sites index ${SNP_LIST}
  $ANGSD -b  bam_list_dec_nodup -ref ${REFERENCE} -out ${OUT} \
        -GL 1 -doGlf 2 -doMaf 1 -doMajorMinor 1 -doCounts 1 \
        -setMinDepth 80 -setMaxDepth 1680 -r ${SCAFFOLD}: \
        -minQ 20 -minMapQ 20 -SNP_pval 1e-6 \
        -P 5 -remove_bads 1 -trim 0 -baq 1 -uniqueOnly 1 \
        -only_proper_pairs 1 -C 50 -sites ${SNP_LIST} >& ${OUT}.log
done


ANGSD=~/Documents/PostDoc/programs/angsd/angsd
REFERENCE=~/Documents/PostDoc/Stickleback/reference_genome/GCF_016920845.1_GAculeatus_UGA_version5_genomic.fna

for SCAFFOLD in NC_053226.1 NC_053227.1 NC_053228.1 NC_053229.1 NC_053230.1 NC_053231.1 NC_053232.1 NC_053233.1; do
  OUT=~/Documents/PostDoc/Stickleback/angsd/pruned/22chr_angsd_dec2_LDpruned_nodup_${SCAFFOLD}
  echo ${SCAFFOLD}
  SNP_LIST=~/Documents/PostDoc/Stickleback/angsd/ngsLD_out/LDpruned_snps_${SCAFFOLD}.list

  $ANGSD sites index ${SNP_LIST}
  $ANGSD -b  bam_list_dec_nodup -ref ${REFERENCE} -out ${OUT} \
        -GL 1 -doGlf 2 -doMaf 1 -doMajorMinor 1 -doCounts 1 \
        -setMinDepth 80 -setMaxDepth 1680 -r ${SCAFFOLD}: \
        -minQ 20 -minMapQ 20 -SNP_pval 1e-6 \
        -P 5 -remove_bads 1 -trim 0 -baq 1 -uniqueOnly 1 \
        -only_proper_pairs 1 -C 50 -sites ${SNP_LIST} >& ${OUT}.log
done



cp 22chr_angsd_dec2_LDpruned_nodup_NC_053212.1.beagle.gz angsd_dec3_LDpruned_nodup_autosomes.beagle.gz
gunzip angsd_dec3_LDpruned_nodup_autosomes.beagle.gz


for SCAFFOLD in NC_053213.1 NC_053214.1 NC_053215.1 NC_053216.1 NC_053217.1 NC_053218.1 NC_053219.1 NC_053220.1 NC_053221.1 NC_053222.1 NC_053223.1 NC_053224.1 NC_053225.1 NC_053226.1 NC_053227.1 NC_053228.1 NC_053229.1 NC_053231.1 NC_053232.1; do
  zcat 22chr_angsd_dec2_LDpruned_nodup_${SCAFFOLD}.beagle.gz | tail -n +2 >> angsd_dec3_LDpruned_nodup_autosomes.beagle
done

gzip angsd_dec3_LDpruned_nodup_autosomes.beagle
```