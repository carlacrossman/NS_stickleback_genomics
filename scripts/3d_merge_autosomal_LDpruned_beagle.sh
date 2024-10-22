cp 22chr_angsd_sept26_LDpruned_NC_053212.1.beagle.gz 22chr_angsd_sept26_LDpruned_autosomes.beagle.gz
gunzip 22chr_angsd_sept26_LDpruned_autosomes.beagle.gz


for SCAFFOLD in NC_053213.1 NC_053214.1 NC_053215.1 NC_053216.1 NC_053217.1 NC_053218.1 NC_053219.1 NC_053220.1 NC_053221.1 NC_053222.1 NC_053223.1 NC_053224.1 NC_053225.1 NC_053226.1 NC_053227.1 NC_053228.1 NC_053229.1 NC_053231.1 NC_053232.1
do
	zcat 22chr_angsd_sept26_LDpruned_${SCAFFOLD}.beagle.gz | tail -n +2 >> 22chr_angsd_sept26_LDpruned_autosomes.beagle
done

gzip 22chr_angsd_sept26_LDpruned_autosomes.beagle