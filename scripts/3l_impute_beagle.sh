#!/bin/bash
#SBATCH --job-name=impute_beagle
#SBATCH --output=%x-%j.out
#SBATCH --account=def-pbentzen
#SBATCH --cpus-per-task=10
#SBATCH --mem=15G
#SBATCH --time=8:00:00

export JAVA_TOOL_OPTIONS="-Xmx14G"


java -Xmx14000m -jar ../beagle/beagle.r1399.jar excludesamples=dup_samples excludemarkers=sex_chrom gt=22chr_snps_angsd_sept28.vcf.gz gprobs=true nthreads=10 out=../association/autosomes_sept28_nodups_beagleout