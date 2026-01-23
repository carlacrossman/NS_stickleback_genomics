###--- 3l Generating SFS ---###

# Using realSFS from ANGSD to calculate the folded site frequency spectrum
# Repeated for each population/group

# Part of the blueprint file calls for the number of sites analyzed. Calculated this with:
```{bash}
for i in {12..29}; do
    grep retained common_other_angsd_NC_0532${i}.1.log >> common_other_sites
done
grep retained common_other_angsd_NC_053231.1.log >> common_other_sites
grep retained common_other_angsd_NC_053232.1.log >> common_other_sites
```

# Create blueprint file
```{bash}
java -cp stairway_plot_es Stairbuilder common_other_blueprint
```

# This generates a *.sh file which will run Stairway Plot with the assigned parameters
