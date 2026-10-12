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

# Include Pairwise FST or IBD analyses #

```{bash}
realSFS common_hrm_merged.saf.idx common_cb_merged.saf.idx -P 12 > hrm.cb.ml
realSFS common_southshore_merged.saf.idx common_cb_merged.saf.idx -P 12 > shouthshore.cb.ml
realSFS common_northumberland_merged.saf.idx common_cb_merged.saf.idx -P 12 > northumberland.cb.ml
realSFS common_bof_merged.saf.idx common_cb_merged.saf.idx -P 12 > bof.cb.ml
realSFS common_southshore_merged.saf.idx common_bof_merged.saf.idx -P 12 > southshore.bof.ml
realSFS common_hrm_merged.saf.idx common_bof_merged.saf.idx -P 12 > hrm.bof.ml
realSFS common_northumberland_merged.saf.idx common_bof_merged.saf.idx -P 12 > northumberland.bof.ml
realSFS common_hrm_merged.saf.idx common_southshore_merged.saf.idx -P 12 > hrm.southshore.ml
realSFS common_nothumberland_merged.saf.idx common_southshore_merged.saf.idx -P 12 > northumberland.southshore.ml
realSFS common_hrm_merged.saf.idx common_northumberland_merged.saf.idx -P 12 > hrm.northumberland.ml

realSFS fst index common_hrm_merged.saf.idx common_northumberland_merged.saf.idx -fstout hrm.northumberland.ceu -sfs hrm.northumberland.ml -P 20
realSFS fst stats hrm.northumberland.ceu.fst.idx > hrm_northumberland_fst

realSFS fst index common_hrm_merged.saf.idx common_southshore_merged.saf.idx -fstout hrm.southshore.ceu -sfs hrm.southshore.ml -P 20
realSFS fst stats hrm.southshore.ceu.fst.idx > hrm_southshore_fst

realSFS fst index common_northumberland_merged.saf.idx common_cb_merged.saf.idx -fstout northumberland.cb.ceu -sfs northumberland.cb.ml -P 20
realSFS fst stats northumberland.cb.ceu.fst.idx > northumberland_cb_fst

realSFS fst index common_northumberland_merged.saf.idx common_bof_merged.saf.idx -fstout northumberland.bof.ceu -sfs northumberland.bof.ml -P 20
realSFS fst stats northumberland.bof.ceu.fst.idx > northumberland_bof_fst

realSFS fst index common_hrm_merged.saf.idx common_bof_merged.saf.idx -fstout hrm.bof.ceu -sfs hrm.bof.ml -P 20
realSFS fst stats hrm.bof.ceu.fst.idx > hrm_bof_fst

realSFS fst index common_southshore_merged.saf.idx common_bof_merged.saf.idx -fstout southshore.bof.ceu -sfs southshore.bof.ml -P 20
realSFS fst stats southshore.bof.ceu.fst.idx > southshore_bof_fst

realSFS fst index common_bof_merged.saf.idx common_cb_merged.saf.idx -fstout bof.cb.ceu -sfs bof.cb.ml -P 20
realSFS fst stats bof.cb.ceu.fst.idx > bof_cb_fst

realSFS fst index common_southshore_merged.saf.idx common_cb_merged.saf.idx -fstout southshore.cb.ceu -sfs southshore.cb.ml -P 20
realSFS fst stats southshore.cb.ceu.fst.idx > southshore_cb_fst
```

We used the genetic distance calculated above and created a distance matrix. This was combined with Structure Results from the microsatellites in R.

```{R}
white_genind_obj <- read.structure("whites_locPheno.str", n.ind = 344, n.loc = 43, onerowperind = FALSE, ask = FALSE, col.lab = 1, col.pop = 2, NA.char = "-9")

white_hierfstat_obj <- genind2hierfstat(white_genind_obj)
white_fst <- pairwise.WCfst(white_hierfstat_obj)
linearized_white_fst <- white_fst / (1 - white_fst)

common_genind_obj <- read.structure("common_locPheno.str", n.ind = 749, n.loc = 43, onerowperind = FALSE, ask = FALSE, col.lab = 1, col.pop = 2, NA.char = "-9")

common_hierfstat_obj <- genind2hierfstat(common_genind_obj)
common_fst <- pairwise.WCfst(common_hierfstat_obj)
linearized_common_fst <- common_fst / (1 - common_fst)
```

```{r}
# importing distance matrix
library(vegan)

distance_table <- read.table("common_usat_distancemat.csv", header = TRUE, row.names = 1, sep = ",")

white_distance_table <- read.table("white_usat_distancemat.csv", header = TRUE, row.names = 1, sep = ",")

lcwgs_distance_table <- read.table("lcwgs_distancemat.csv", header = TRUE, row.names = 1, sep = ",")

##Common with usats
common_fst_edit <- as.dist(linearized_common_fst)
distance_table_edit <- as.dist(distance_table)
vegan::mantel(as.dist(linearized_common_fst), as.dist(distance_table))

##White with usats
white_fst_edit <- as.dist(linearized_white_fst)
white_distance_table_edit <- as.dist(white_distance_table)
vegan::mantel(as.dist(linearized_white_fst), as.dist(white_distance_table))

##lcwgs

lcwgs_fst <- read.table("pairwise_fst_lcwgs.csv", header = TRUE, row.names = 1, sep = ",")
linearized_lcwgs_fst <- lcwgs_fst / (1 - lcwgs_fst)

vegan::mantel(as.dist(linearized_lcwgs_fst), as.dist(lcwgs_distance_table))
lcwgs_fst_edit <- as.dist(linearized_lcwgs_fst)
lcwgs_distance_table_edit <- as.dist(lcwgs_distance_table)
```

Estimate minomum marine distance

```{R}
source("https://raw.githubusercontent.com/jorgeassis/marineDistances/master/Script.R")

global.polygon <- "GSHHS_l_L1.shp"

data_points <- sample_locations_wgs %>%
  select(name, latitude, longitude) %>%
  filter(name %in% c("Baddeck", "Rainbow Haven", "L'Hebert", "Gaspereau River", "Cross Road Bridge"))
         
data_points <- rbind(data_points, c("Northumberland", 45.78396, -62.80218))

#write.csv(data_points,"lcwgs_sample_sites.txt",col.names = FALSE, row.names = FALSE, quote = FALSE)


contour( global.polygon = global.polygon , file= "lcwgs_sample_sites.txt" , file.sep = "," , file.dec = "." , file.strucutre = 2 , file.header = FALSE , resolution = 0.01 , buffer = c(5,5,5,5) , export.file = TRUE )
```

# Calculate IBD #

```{R}
#Import distance table
library(dendextend)

long_dist_common <- dist_long(distance_table_edit)
long_fst_common <- dist_long(common_fst_edit)
colnames(long_fst_common) <- c("rows","cols", "fst")
common_data_ibd_plot <- full_join(long_dist_common, long_fst_common)

long_dist_white <- dist_long(white_distance_table_edit)
long_fst_white <- dist_long(white_fst_edit)
colnames(long_fst_white) <- c("rows","cols", "fst")
white_data_ibd_plot <- full_join(long_dist_white, long_fst_white)

long_dist_lcwgs <- dist_long(lcwgs_distance_table_edit)
long_fst_lcwgs <- dist_long(lcwgs_fst_edit)
colnames(long_fst_lcwgs) <- c("rows","cols", "fst")
lcwgs_data_ibd_plot <- full_join(long_dist_lcwgs, long_fst_lcwgs)

IBD_plot <- ggplot() +
  geom_point(aes(common_data_ibd_plot$distance, common_data_ibd_plot$fst), pch=1, colour = "purple4")+
  geom_smooth(aes(common_data_ibd_plot$distance, common_data_ibd_plot$fst), method = "lm", se = TRUE, colour = "purple4", fill = "purple4") +
  geom_point(aes(white_data_ibd_plot$distance, white_data_ibd_plot$fst), pch=2, colour = "goldenrod") +
  geom_smooth(aes(white_data_ibd_plot$distance, white_data_ibd_plot$fst), method = "lm", se = TRUE, colour = "goldenrod", fill = "goldenrod") +
  geom_point(aes(lcwgs_data_ibd_plot$distance, lcwgs_data_ibd_plot$fst), pch=19) +
  geom_smooth(aes(lcwgs_data_ibd_plot$distance, lcwgs_data_ibd_plot$fst), method = "lm", se = TRUE, colour = "black") +
  xlab("Geographic Distance (km)") +
  ylab(expression(Linearized~F[ST])) +
  theme_bw()

```