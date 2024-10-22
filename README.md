## Scripts used to date for stickleback analyses
This repository is still in development as the analyses continue.

**scripts/**

- *1a_trimming.sh*	Trim raw sequence reads
- *1b_fastqc.sh*	Running FASTQC on trimmed reads
- *1c_index_reference.sh*	Prepare reference genome
- *1d_mapping.sh*	Map to reference assembly
- *1e_qualimap.sh*	Run qualimap to assess mapping statistics
- *1f_duplicate_subset_bam.sh*	Mark duplicate reads, sort and subset bam files into mtDNA and near chromosome length scaffolds
  
- *2a_mtdna_haplotype_caller.sh*	Part of the variant calling pipeline from GATK 
- *2b_genomicsdb.sh*	Part of the variant calling pipeline from GATK 
- *2c_genotype_gvcfs.sh*	Part of the variant calling pipeline from GATK 
- *2d_normalize_filter_mtdna_variants.sh*	Normalize and filter variants across samples
- *2e_consensus_mtdna.sh*	Generate a consensus sequence of the mitogenome for each individual
- *2f_align_fasta.sh*	Aligning fasta sequences into a single multisequence alignment
  
- *3a_angsd_first_round.sh*	Generates first genotype likelihood files  
- *3b_plink_estimate_LD.sh*	Esitmates linkage disequlibrium and prunes snp list  
- *3c_angsd_drop_linked_sites.sh*	Drops linked SNPs using ANGSD  
- *3d_merge_autosomal_LDpruned_beagle.sh*	Merge autosomal beagle files  
- *3e_remove_dups.sh*	Remove duplicate samples  
- *3f_pcangsd.sh*	Runs PCAngsd  
- *3g_ngsadmix.sh*	Runs ngsADMIX  
- *3h_concatenate_bcf.sh*	Concatenate bcf files into a merged vcf  
- *3i_check_reproducibility.sh*	Measure reproducibility of duplicate samples  
- *3j_concatenate_beagle_drop_dups.sh*	Concatenate across scaffolds and drop duplicates  
- *3k_confirm_sexes.sh*	Confirm genetic sexes  
- *3l_impute_beagle.sh*	Imputation in Beagle  
- *3m_pairwise_FST_windowed.sh*	Calcualtes pairwise FST (windowed) - also ran on reassigned phenotypes  
- *3n_angsd_association.sh* Association testing in ANGSD - also ran on reassigned phenotypes  

- *other_unsorted/*	This directory contains scripts and lines of code used for other steps not yet orgianized/completed

![Data_prep](https://github.com/carlacrossman/NS_stickleback_genomics/blob/main/Stickleback_data_prep.jpg)
  
![mtDNA_analysis](https://github.com/carlacrossman/NS_stickleback_genomics/blob/main/Stickleback_mtDNA_data_analysis.jpg)
  
![nuclear_analysis](https://github.com/carlacrossman/NS_stickleback_genomics/blob/main/Stickleback_nuclear_data_analysis.jpg)
