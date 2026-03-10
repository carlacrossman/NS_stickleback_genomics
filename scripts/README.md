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
  
- *3a_angsd_first_round.md*	Generates first genotype likelihood files  
- *3b_LD_Pruning.md*	Esitmates linkage disequlibrium and prunes snp list  
- *3c_angsd_pruned.md*	Drops linked SNPs using ANGSD  
- *3d_pcangsd.md*	Runs PCAngsd 
- *3e_ngsadmix.md*	Runs ngsADMIX 
- *3f_sexing.md*	Confirm genetic sexes  
- *3g_reproducibility.md*	Measure reproducibility of duplicate samples 
- *3h_outgroup_prep.md*	Prepare the outgroups from .fastq to .bam files 
- *3i_outgroup_angsd.md* Calculating genotype likelihoods for outgroups  
- *3j_phylogeny.md*	Calculating genetic distance and building phylogeny  
- *3k_angsd_SAF.md*	Calculate site allele frequency likelihoods 
- *3l_generating_SFS.md*	Estimate the SFS  
- *3m_running_stairwayplot.md*	Running Stairway Plot  
- *3n_pairwise_fst.md*	Calculating pairwise FST

![Data_prep](https://github.com/carlacrossman/NS_stickleback_genomics/blob/main/Stickleback_data_prep.jpg)
  
![mtDNA_analysis](https://github.com/carlacrossman/NS_stickleback_genomics/blob/main/stickleback_mtDNA_data_analysis.jpg)
  
![nuclear_analysis](https://github.com/carlacrossman/NS_stickleback_genomics/blob/main/stickleback_nuclear_data_analysis.jpg)
