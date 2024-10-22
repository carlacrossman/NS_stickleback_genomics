#!/bin/bash
#SBATCH --job-name=pcangsd
#SBATCH --output=%x-%j.out
#SBATCH --account=def-pbentzen
#SBATCH --cpus-per-task=10
#SBATCH --mem=40G
#SBATCH --time=12:00:00

pcangsd --beagle ../angsd/22chr_angsd_sept26_LDpruned_autosomes.beagle.gz --out stickleback_angsd_pcangsd_autosome --threads 10