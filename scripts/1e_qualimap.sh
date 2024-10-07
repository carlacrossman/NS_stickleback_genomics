#!/bin/bash
#SBATCH --job-name=qualimap
#SBATCH --output=%x-%j.out
#SBATCH --account=def-pbentzen
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=6:00:00

module load mugqic/qualimap/2.2.1
module load mugqic/java/openjdk-jdk-11.0.2

#OUT_DIR=~/scratch/stickleback/temp_mapping/qualimap/

export JAVA_TOOL_OPTIONS="-Xmx8G"

#qualimap multi-bamqc -d qualimap_last \
#        -outdir ${OUT_DIR} -nr 10000 \
#        --java-mem-size=8G -r

qualimap multi-bamqc -d qualimap_sept18_input -outdir qualimap_sept18_compiled/

