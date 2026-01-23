### --- 3j Phylogeny --- ###

# In order to build a phylogentic tree, we need to 
#   - merge the outgroup and the main data
#   - calculate a distance matrix with ngsDist (v.1.0.10)
#   - create tree files with FASTme (v.2.1.6.2)
#   - bootstrap the tree with raxml-ng (v.1.2.0)


# First in R we need to merge the main dataset and the outgroup
```{R}
# Load libraries
library(readr)
library(data.table)
library(dplyr)
library(tidyr)

# Load data files 
all_samples <- data.table::fread("../merged_dec1_angsd1.beagle", header = TRUE)
all_samples_names <- fread("ind_names", header = FALSE)
outgroups <- data.table::fread("merged_european_outgroup_autosomes.beagle", header = TRUE)
outgroup_names <- fread("european_outgroup_names", head = FALSE)


# Extract the position information from each dataset and separate genotype likelihood information
outgroup_positions <- outgroups %>%
  select(marker) %>%
  separate_wider_delim(marker, delim = ".1_", names = c("chr", "pos"))

outgroup_data <- outgroups[,-1]

all_samples_positions <- all_samples %>%
  select(marker) %>%
  separate_wider_delim(marker, delim = ".1_", names = c("chr", "pos"))

all_samples_data <- all_samples[,-1]

# Delete the original files from memory in R as they are very large and unnecessary at this point
rm(all_samples)
rm(outgroups)

# Change col names per index
colnames(outgroup_data) <- c("allele1", "allele2", outgroup_names$V1)
colnames(all_samples_data) <- c("allele1", "allele2", all_samples_names$V1)

# Recombine the positions and GL dataframes
all_sample_new <- cbind(all_samples_positions, all_samples_data)
outgroup_new <- cbind(outgroup_positions, outgroup_data)

# Delete the original files from memory in R as they are very large and unnecessary at this point
rm(all_samples_positions)
rm(all_samples_data)
rm(outgroup_positions)
rm(outgroup_data)

# Set temporary column names so as not to have duplicates when joining
colnames(all_sample_new) <- c("chr","pos","allele1", "allele2",1:720)
colnames(outgroup_new) <- c("chr","pos","allele1", "allele2",990:995)

# Perform inner join to merge the two on all sites called in each file
merged <- inner_join(all_sample_new, outgroup_new, by = c("chr", "pos", "allele1", "allele2"))

# Fix names
colnames(merged) <- c("chr", "pos", "allele1", "allele2", all_samples_names$V1, outgroup_names$V1)

# Save table as the new beagle file with sites called in both outgroups and the main dataset
write.table(merged, file = "merged_GL_withdups_with_european_outgroup.beagle", sep = "\t", row.names = FALSE, quote = FALSE)
```
```{bash}
gzip merged_GL_withdups_with_european_outgroup.beagle```


# Check number of SNPs (This number will also include the header)
zcat merged_GL_withdups_with_european_outgroup.beagle.gz | wc -l

# Create a file with position info
zcat merged_GL_withdups_with_european_outgroup.beagle.gz | awk '{print $1, $2, $3, $4}' > european_ngsdist_pos_info
sed -i 's,\s,\t,g' european_ngsdist_pos_info


# Run ngsDist
./ngsDist --geno merged_GL_withdups_with_european_outgroup.beagle.gz \
   --probs \
   --n_ind 242 \
   --n_sites 4209997 \
   --n_threads 32 \
   --posH ngsdist_pos_info \
   --labels labels_single \
   --verbose 2 \
   --evol_model 2 \
   --n_boot_rep 100 \
   --boot_block_size 100 \
   --out european_ngsdist_output_bootstrapped


# Run FASTME

module load StdEnv/2020
module load fastme

fastme -T 5 -i ../ngsDist/european_ngsdist_output_bootstrapped -s -D 101 -o european_bootstrapped_ngsDist_tree.nwk


# Extract just the main tree

head -n 1 european_bootstrapped_ngsDist_tree.nwk > european_bootstrapped_ngsDist_tree.main.nwk
tail -n +2 european_bootstrapped_ngsDist_tree.nwk | awk 'NF' > european_bootstrapped_ngsDist_tree.boot.nwk

# Run RAxML-ng to plot bootstrap values on main tree
module raxml-ng

raxml-ng --support --threads 5 --tree ../european_bootstrapped_ngsDist_tree.main.nwk --bs-trees ../european_bootstrapped_ngsDist_tree.boot.nwk --prefix raxml_european_bootstrapped_tree
```
