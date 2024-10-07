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

- *other_unsorted/*	This directory contains scripts and lines of code used for other steps and or the nuclear data not yet orgianized/completed

![Data_prep](https://github.com/carlacrossman/stickleback_genomics/Stickleback_data_prep.jpg)
![mtDNA_analysis](https://github.com/carlacrossman/stickleback_genomics/Stickleback_mtDNA_data_analysis.jpg)
