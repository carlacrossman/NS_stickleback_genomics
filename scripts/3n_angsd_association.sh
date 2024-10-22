module load bcftools/1.19

bcftools index 22chr_sept28_nodups_beagleout.vcf.gz
bcftools view -r NC_053212.1,NC_053213.1,NC_053214.1,NC_053215.1,NC_053216.1,NC_053217.1,NC_053218.1,NC_053219.1,NC_053220.1,NC_053221.1,NC_053222.1,NC_053223.1,NC_053224.1,NC_053225.1,NC_053226.1,NC_053227.1,NC_053228.1,NC_053229.1,NC_053231.1,NC_053232.1 -Oz -o autosomes_sept28_nodups_beagleout.vcf.gz 22chr_sept28_nodups_beagleout.vcf.gz 

bcftools index autosomes_sept28_nodups_beagleout.vcf.gz

#The following has to be run in each of the directories for each comparison. For each, specify the relevant OUT dir/

#in each directory:
OUT=BoF_CBCommon_Males
OUT=BoFAll_NonCBCommonMales
OUT=CB_Mainland_CommonMales
OUT=CBCommon_CBWhite_Males
OUT=MainlandCommon_MainlandWhite_Males

bcftools view -S ${OUT}/${OUT}_list -Oz -o ${OUT}/autosomes_sept28_nodups_beagleout_${OUT}.vcf.gz autosomes_sept28_nodups_beagleout.vcf.gz


# Then run ANGSD in each directory

OUT=BoF_CBCommon_Males
OUT=BoFAll_NonCBCommonMales
OUT=CB_Mainland_CommonMales
OUT=CBCommon_CBWhite_Males
OUT=MainlandCommon_MainlandWhite_Males

cd ../${OUT}

module load angsd

angsd \
  -doMaf 4 \
  -vcf-gp autosomes_sept28_nodups_beagleout_${OUT}.vcf.gz \
  -fai /home/crossman/scratch/stickleback/reference_genome/GCF_016920845.1_GAculeatus_UGA_version5_genomic.fna.fai  \
  -yBin ${OUT}_ybin  \
  -out ${OUT}_assoc \
  -doAsso 4 \
  -nthreads 5