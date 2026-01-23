###--- 3k ANGSD for SAF ---###
# Running ANGSD to produce saf files 

```{bash}
REFERENCE=~/Documents/PostDoc/Stickleback/reference_genome/GCF_016920845.1_GAculeatus_UGA_version5_genomic.fna
ANGSD=~/Documents/PostDoc/programs/angsd/angsd

{ for SCAFFOLD in NC_053212.1 NC_053213.1 NC_053214.1 NC_053215.1 NC_053216.1 NC_053217.1 NC_053218.1 NC_053219.1 NC_053220.1 NC_053221.1 NC_053222.1 NC_053223.1 NC_053224.1 NC_053225.1 NC_053226.1 NC_053227.1 NC_053228.1 NC_053229.1 NC_053231.1 NC_053232.1; do
  OUT=~/Documents/PostDoc/Stickleback/sfs/common_other_angsd_${SCAFFOLD}
  echo ${SCAFFOLD}
  $ANGSD -bam common_other_bam -anc ${REFERENCE} -out ${OUT} \
      -minQ 20 -minMapQ 20 -uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -trim 0 \
      -r ${SCAFFOLD}: -GL 1 -nThreads 5 -doSaf 1 >& ${OUT}.log
done; } &
```
