###--- 3n Pairwise FST ---###

# Using realSFS from ANGSD to use the folded site frequency spectrum
# to calculate the pairwise FST and the windowed FST



```{bash}
realSFS common_other_merged.saf.idx common_cb_merged.saf.idx -P 12 > mainland.cb.ml
realSFS common_other_merged.saf.idx common_bof_merged.saf.idx -P 12 > mainland.bof.ml
realSFS common_bof_merged.saf.idx common_cb_merged.saf.idx -P 12 > bof.cb.ml
realSFS white_merged.saf.idx common_cb_merged.saf.idx -P 12 > white.cb.ml
realSFS white_merged.saf.idx common_bof_merged.saf.idx -P 12 > white.bof.ml
realSFS white_merged.saf.idx common_other_merged.saf.idx -P 12 > white.other.ml

realSFS fst index common_other_merged.saf.idx common_cb_merged.saf.idx -fstout mainland.cb.ceu -sfs mainland.cb.ml
realSFS fst index common_cb_merged.saf.idx common_other_merged.saf.idx -fstout mainland.cb.ceu -sfs mainland.cb.ml -P 8
realSFS fst index common_cb_merged.saf.idx white_merged.saf.idx -fstout white.cb.ceu -sfs white.cb.ml -P 8
realSFS fst index common_other_merged.saf.idx common_bof_merged.saf.idx -fstout mainland.bof.ceu -sfs mainland.bof.ml
realSFS fst index common_bof_merged.saf.idx white_merged.saf.idx -fstout white.bof.ceu -sfs white.bof.ml -P 8
realSFS fst index common_other_merged.saf.idx white_merged.saf.idx -fstout white.other.ceu -sfs white.other.ml -P 8

realSFS fst stats bof.cb.ceu.fst.idx
realSFS fst stats mainland.cb.ceu.fst.idx > maindland_cb_fst
realSFS fst stats white.cb.ceu.fst.idx > white_cb_fst
realSFS fst stats white.bof.ceu.fst.idx > white_bof_fst
realSFS fst stats white.other.ceu.fst.idx > white_other_fst
realSFS fst stats mainland.bof.ceu.fst.idx > mainland_bof_fst

realSFS fst stats2 mainland.cb.ceu.fst.idx -win 10000 -step 10000 -type 2 > slidingwindowBackground_mainland_cb
realSFS fst stats2 mainland.bof.ceu.fst.idx -win 10000 -step 10000 -type 2 > slidingwindowBackground_mainland_bof
```

Identify the outliers in R:
```{r}
library(dplyr)
library(ggplot2)

Mainland_CB_Common_fst <- read.table("slidingwindowBackground_mainland_cb", sep="\t", header=TRUE, row.names = NULL)
colnames(Mainland_CB_Common_fst) <- c("region", "Chrom", "Midpoint", "NSites", "FST")
Mainland_CB_Common_fst$plot_pos <- c(1:41527)
outliers_bof <- Mainland_BoF_Common_fst %>% 
                  filter(FST > 0.295)
mainland_bof_outliers <- outliers_bof %>% 
                              mutate(START=Midpoint-5000) %>% 
                              mutate(END=Midpoint+5000) %>% 
                              select(Chrom, START, END)
write.table(mainland_bof_outliers, "mainland_bof_outliers.bed", sep="\t", quote = FALSE, col.names = FALSE, row.names = FALSE)


Mainland_BoF_Common_fst <- read.table("slidingwindowBackground_mainland_bof", sep="\t", header=TRUE, row.names = NULL)
colnames(Mainland_BoF_Common_fst) <- c("region", "Chrom", "Midpoint", "NSites", "FST")
Mainland_BoF_Common_fst$plot_pos <- c(1:41529)
outliers_cb <-  Mainland_CB_Common_fst %>% 
                  filter(FST > 0.2488)
mainland_cb_outliers <- outliers_cb %>% 
                              mutate(START=Midpoint-5000) %>% 
                              mutate(END=Midpoint+5000) %>% 
                              select(Chrom, START, END)
write.table(mainland_cb_outliers, "mainland_cb_outliers.bed", sep="\t", quote = FALSE, col.names = FALSE, row.names = FALSE)
```

Identify genes in the outlier regions with bedtools v.2.31 using the annotations provided with the genome.

```{bash}
bedtools intersect -wa -a GCF_016920845.1_GAculeatus_UGA_version5_genomic.gtf -b mainland_bof_outliers.bed > mainland_bof_outliers_genes_nowindow

bedtools intersect -wa -a GCF_016920845.1_GAculeatus_UGA_version5_genomic.gtf -b mainland_cb_outliers.bed > mainland_cb_outliers_genes_nowindow
```