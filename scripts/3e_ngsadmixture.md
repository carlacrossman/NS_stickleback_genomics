### --- 3e ngsADMIXTURE --- ###

# Running 10 iterations of ngsADMIX for K1-K6
# After each run, extract log-likelihood values and determine the best K
# Using Clumpak, merge the 10 iterations for those we wish to plot


```{bash}
#!/bin/bash
#SBATCH --job-name=ngsadmix_1-6
#SBATCH --output=%x-%j.out
#SBATCH --account=def-pbentzen
#SBATCH --array=1-10
#SBATCH --cpus-per-task=10
#SBATCH --mem=40G
#SBATCH --time=10:00:00

module load angsd/0.940
module load admixture/1.3.0

for K in {1..6}; do
        echo ${K}
        NGSadmix \
        -likes ../pruned_dec3/angsd_dec3_LDpruned_nodup_autosomes.beagle.gz \
        -K ${K} \
        -P 10 \
        -o ngsadmix_LDpruned_autosomes_k${K}_${SLURM_ARRAY_TASK_ID} \
        -minMaf 0.05
done
```

# Save likelihood from each iteration
```{bash}
for K in {1..6}; do for ITERATOR in {1..10}; do grep ^best ngsadmix_LDpruned_autosomes_k${K}_${ITERATOR}.log | sed 's,\(best\slike=\)\(.*\)\(\safter.*\),\2,' >> K${K}_like; done; done
```

For each of these files, calculate the mean log-likelihood value with: mean(abs(K#_like))/sd(abs(K#_like))
```{R}

k1<-read.table("K1_like")
mean(abs(k1$V1))/sd(abs(k1$V1))
k2<-read.table("K2_like")
mean(abs(k2$V1))/sd(abs(k2$V1))
k3<-read.table("K3_like")
mean(abs(k3$V1))/sd(abs(k3$V1))
k4<-read.table("K4_like")
mean(abs(k4$V1))/sd(abs(k4$V1))
k5<-read.table("K5_like")
mean(abs(k5$V1))/sd(abs(k5$V1))
k6<-read.table("K6_like")
mean(abs(k6$V1))/sd(abs(k6$V1))

```
Mean log-likelihood values for each K (highest is the best)

K1 - 1.881135e+14
K2 - 1122044212
K3 - 69206625
K4 - 15078031
K5 - 5525.436
K6 - 3460.929

# Use CLUMPAK (https://clumpak.evolseq.net/index.html) to average results files across the 10 iterations for K2, K3 and K4
# Plot the results in R