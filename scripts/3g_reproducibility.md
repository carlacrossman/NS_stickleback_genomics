### --- 3g Reproducibility --- ###

# Our sequencing run included four samples run in duplicate
# These were included to check/verify the repeataility of our finidings.
# As these data are likelihood and not hard genotype calls, comparing the two samples is tricky.
# Ideally, these will be clusters with strong support on a phylogentic tree.
# We also wanted to compare the GL values at each called site to identify mismatches within each pair of duplicates.
#
# The follow code uses AWK to extract the GL data for each sample of interest. 
# There is also an R script that calculates the reproducibility of data by identifyng the proportion of sites
# where the highest likelihood is the same genotype within each pair, and also reports on this ignoring sites 
# where the highest likelihood was tied between two possible genotypes. 

```{bash}
#Ind98 IR-343-C
awk '{print $1, $2, $3, $298, $299, $300}' merged_dec1_angsd1.beagle > reproducibility/IR-343-C_GL
#Ind99 IR-343-C-RED
awk '{print $1, $2, $3, $301, $302, $303}' merged_dec1_angsd1.beagle > reproducibility/IR-343-C-RED_GL

#Ind129  M159
awk '{print $1, $2, $3, $391, $392, $393}' merged_dec1_angsd1.beagle > reproducibility/M159_GL
#Ind130  M159-RED
awk '{print $1, $2, $3, $394, $395, $396}' merged_dec1_angsd1.beagle > reproducibility/M159-RED_GL

#Ind163  MTC30
awk '{print $1, $2, $3, $493, $494, $495}' merged_dec1_angsd1.beagle > reproducibility/MTC30_GL
#Ind164  MTC30-RED
awk '{print $1, $2, $3, $496, $497, $498}' merged_dec1_angsd1.beagle > reproducibility/MTC30-RED_GL

#Ind213  RED-THA-C
awk '{print $1, $2, $3, $643, $644, $645}' merged_dec1_angsd1.beagle > reproducibility/THA-C-RED_GL
#Ind235  THA-C
awk '{print $1, $2, $3, $709, $710, $711}' merged_dec1_angsd1.beagle > reproducibility/THA-C_GL
```

```{R}
library(dplyr)
library(data.table)

column_with_max <- function(..., na.rm = FALSE) {
  nms <- as.character(ensyms(...))
  vals <- c(...)
  max_val <- max(vals, na.rm = na.rm)
  if (is.na(max_val)) return(NA_character_)
  max_idx <- which(near(vals, max_val))
  if (length(max_idx) > 1) return("tie")
  nms[[max_idx]]
}

compare_genotypes <- function(data){
  i <- length(which(data[,1] == data[,2]))
  j <- nrow(data)
  rows_with_tie <- which(apply(data, 1, function(row) any(row == "tie")))
  temp <- data[-(rows_with_tie),]
  k <- length(which(temp[,1] == temp[,2]))
  l <- nrow(temp)
  print(paste0("Number matching sites: ", i))
  print(paste0("Total number of sites: ", j))
  print(paste0("Percent all sites same highest GL: ", i/j))
  print(paste0("Number of sites with tied GT calls in either rep: ", length(rows_with_tie)))
  print(paste0("Number matching sites no tied GT: ", k))
  print(paste0("Total number of sites no tied GT: ", l))
  print(paste0("Percent all sites same highest GL no tied GT: ", k/l))
}

top_genotypes <- function(sample1, sample2, na.rm = FALSE){
  indA <- sample1 %>%
    rowwise() %>%
    mutate(max_column = column_with_max(GT1, GT2, GT3)) %>%
    ungroup() %>%
    select(max_column)
  indB <- sample2 %>%
    rowwise() %>%
    mutate(max_column = column_with_max(GT1, GT2, GT3)) %>%
    ungroup() %>%
    select(max_column)
  joined <- cbind(indA, indB)
  compare_genotypes(joined)
}

IR_343_C <- fread("IR-343-C_GL", header = TRUE)
IR_343_C <- IR_343_C[,4:6]
colnames(IR_343_C) <- c("GT1", "GT2", "GT3")

IR_343_C_RED <- fread("IR-343-C-RED_GL", header = TRUE)
IR_343_C_RED <- IR_343_C_RED[,4:6]
colnames(IR_343_C_RED) <- c("GT1", "GT2", "GT3")

M159 <- fread("M159_GL", header = TRUE)
M159 <- M159[,4:6]
colnames(M159) <- c("GT1", "GT2", "GT3")

M159_RED <- fread("M159-RED_GL", header = TRUE)
M159_RED <- M159_RED[,4:6]
colnames(M159_RED) <- c("GT1", "GT2", "GT3")

MTC30 <- fread("MTC30_GL", header = TRUE)
MTC30 <- MTC30[,4:6]
colnames(MTC30) <- c("GT1", "GT2", "GT3")

MTC30_RED <- fread("MTC30-RED_GL", header = TRUE)
MTC30_RED <- MTC30_RED[,4:6]
colnames(MTC30_RED) <- c("GT1", "GT2", "GT3")

THA_C <- fread("THA-C_GL", header = TRUE)
THA_C <- THA_C[,4:6]
colnames(THA_C) <- c("GT1", "GT2", "GT3")

THA_C_RED <- fread("THA-C-RED_GL", header = TRUE)
THA_C_RED <- THA_C_RED[,4:6]
colnames(THA_C_RED) <- c("GT1", "GT2", "GT3")

top_genotypes(IR_343_C, IR_343_C_RED)
top_genotypes(M159, M159_RED)
top_genotypes(MTC30, MTC30_RED)
top_genotypes(THA_C, THA_C_RED)
```
