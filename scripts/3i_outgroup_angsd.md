# Generating a list of sites from the first ANGSD run on the larger dataset to use as input for running ANGSD on the outgroup. This sites input also includes the major and minor allele as called from the larger set so that the datasets can be more easily combined. 

```{R}
library(readr)


# Repeat for each chromosome

pruned_position <- read.table("../NC_053233.1_dec1_pos_list")

colnames(pruned_position) <- c("chromo", "position")

snp_list <- read.table( "../22chr_snps_angsd_dec1_NC_053233.1.mafs.gz", stringsAsFactors = F, header = T)[,1:4]

pruned_snp_list <- snp_list[snp_list$position %in% pruned_position$position, ]
  
write.table(pruned_snp_list, paste0("NC_053233.1_outgroup.sites"), col.names = F, row.names = F, quote = F, sep = "\t")
```

# Running ANGSD to calculate genotype likelihood for the outgroups at the same sites as called for the main dataset 

```{bash}
ANGSD=~/Documents/PostDoc/programs/angsd/angsd

REFERENCE=~/Documents/PostDoc/Stickleback/reference_genome/GCF_016920845.1_GAculeatus_UGA_version5_genomic.fna

for SCAFFOLD in NC_053212.1 NC_053213.1 NC_053214.1 NC_053215.1 NC_053216.1 NC_053217.1 NC_053218.1 NC_053219.1 NC_053220.1 NC_053221.1 NC_053222.1 NC_053223.1 NC_053224.1 NC_053225.1 NC_053226.1 NC_053227.1 NC_053228.1 NC_053229.1 NC_053230.1 NC_053231.1 NC_053232.1 NC_053233.1; do
  OUT=~/Documents/PostDoc/Stickleback/angsd/outgroup/european_outgroup_22chr_angsd_${SCAFFOLD}
  echo ${SCAFFOLD}
  SNP_LIST=~/Documents/PostDoc/Stickleback/angsd/outgroup/${SCAFFOLD}_outgroup.sites
  $ANGSD -b  european_outgroup_bam_list -ref ${REFERENCE} -out ${OUT} \
        -minQ 20 -minMapQ 20 -r ${SCAFFOLD}: \
        -uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -trim 0 \
        -nThreads 6 -C 50 -baq 1 -GL 1 -doGlf 2 -doMaf 1 \
        -sites ${SNP_LIST} -doMajorMinor 3 -docounts 1 --ignore-RG 0 >& ${OUT}.log
done

# Merge the beagle output into a single file  

cp outgroup_22chr_angsd_NC_053212.1.beagle.gz merged_outgroup_autosomes.beagle.gz
gunzip merged_outgroup_autosomes.beagle.gz


for SCAFFOLD in NC_053213.1 NC_053214.1 NC_053215.1 NC_053216.1 NC_053217.1 NC_053218.1 NC_053219.1 NC_053220.1 NC_053221.1 NC_053222.1 NC_053223.1 NC_053224.1 NC_053225.1 NC_053226.1 NC_053227.1 NC_053228.1 NC_053229.1 NC_053231.1 NC_053232.1
do
  zcat outgroup_22chr_angsd_${SCAFFOLD}.beagle.gz | tail -n +2 >> merged_outgroup_autosomes.beagle
done
```
