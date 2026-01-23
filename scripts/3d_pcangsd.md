### --- 3d PCAngsd --- ###

# Running a PCA on the genotype likelihood data files we generated after linkage pruning

# PCAngsd v1.36.4

```{bash}
module load python/3.11.5
module load scipy-stack/2024b

cd pcangsd/
source ENV/bin/activate


pcangsd --beagle ../pruned_dec3/angsd_dec3_LDpruned_nodup_autosomes.beagle.gz --out stickleback_angsd_pcangsd_autosome_dec3_repeat --threads 5
```
