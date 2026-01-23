### --- 3b LD Pruning --- ###

# NGSLD version 1.2.1
# PRUNE GRAPH version 0.3.4
#
# Looping through each scaffold, this code generates a list of the variant sites called from ANGSD and counts them.
# These are used as input for NGSLD to estimate pairwise linkage.
# Pairwise linkage values are then used as input to prune linked sites.
# The list of sites need to be manipulated in R to be the correct format to be used as input in ANGSD.
# The final output is a list of unlinked sites that will be used as input for ANGSD.

```{bash}
NGSLD=~/Documents/PostDoc/programs/ngsLD/ngsLD
PRUNEGRAPH=~/Documents/PostDoc/programs/prune_graph/target/release/prune_graph

for SCAFFOLD in NC_053212.1 NC_053213.1 NC_053214.1 NC_053215.1 NC_053216.1 NC_053217.1 NC_053218.1 NC_053219.1 NC_053220.1 NC_053221.1 NC_053222.1 NC_053223.1 NC_053224.1 NC_053225.1 NC_053226.1 NC_053227.1 NC_053228.1 NC_053229.1 NC_053230.1 NC_053231.1 NC_053232.1 NC_053233.1; do

  zcat 22chr_snps_angsd_dec1_${SCAFFOLD}.beagle.gz | grep ^NC | wc -l > num_sites
  SITES=$(cat num_sites)

  zcat 22chr_snps_angsd_dec1_${SCAFFOLD}.beagle.gz | grep ^NC | sed 's,\(NC_0532[0-9]\+\.1\)_\([0-9]\+\).*,\1\t\2,' > ${SCAFFOLD}_dec1_pos_list

  $NGSLD \
    --geno 22chr_snps_angsd_dec1_${SCAFFOLD}.beagle.gz \
    --pos ${SCAFFOLD}_dec1_pos_list \
    --prob TRUE \
    --n_ind 240 \
    --n_sites $SITES \
    --max_kb_dist 100 \
    --rnd_sample 0.05 \
    --n_threads 5 \
    --out ngsLD_out/22chr_snps_${SCAFFOLD}.ld

  $PRUNEGRAPH --in ngsLD_out/22chr_snps_${SCAFFOLD}.ld \
    --header \
    --weight-field r2 \
    --weight-filter "dist <= 100000 && r2 >= 0.5" \
    -n 10 \
    -v \
    --out ngsLD_out/22chr_snps_angsd_unlinked_${SCAFFOLD}.id
done
```

# In R: reformat the list of unlinked sites to be in the proper format for ANGSD input
```{R}
library(readr)

# Repeat for each scaffold

pruned_position <- as.integer(gsub("NC_053232.1:", "", readLines("22chr_snps_angsd_unlinked_NC_053232.1.id")))

snp_list <- read.table( "../22chr_snps_angsd_dec1_NC_053232.1.mafs.gz", stringsAsFactors = F, header = T)[,1:4]

pruned_snp_list <- snp_list[snp_list$position %in% pruned_position, ]

write.table(pruned_snp_list, paste0("LDpruned_snps_NC_053232.1.list"), col.names = F, row.names = F, quote = F, sep = "\t")
```