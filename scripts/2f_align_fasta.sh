#!/bin/bash
#SBATCH --job-name=clutalo
#SBATCH --output=%x-%j.out
#SBATCH --account=def-pbentzen
#SBATCH --cpus-per-task=10
#SBATCH --mem=10G
#SBATCH --time=4:00:00

module load StdEnv/2020 gcc/9.3.0 clustal-omega/1.2.4

clustalo --in consensus_stickleback_mtDNA_sept11.fa --out aligned_consensus_stickleback_mtDNA_sept11.fa --threads=10
