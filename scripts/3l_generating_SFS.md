###--- 3l Generating SFS ---###

# Using realSFS from ANGSD to calculate the folded site frequency spectrum
# This is repeated for each population/group

```{bash}
ls -f common_other_angsd*.saf.idx >  common_other_list

$REALSFS  ../common_other_merged.saf.idx -maxIter 100000 -tole 1e-6 -fold 1 -P 10 2> common_other_log_file > common_other_merged_Folded.sfs


sed 's,\s,\n,g' common_other_merged_Folded.sfs | sed 1d | grep -v ^0 > corrected_common_other_merged_Folded.sfs
```

