module load vcftools/0.1.16

VCF=../22chr_sept28_nodups_beagleout.vcf.gz

#Comparison 1: BoF_CBCommonMales
POP1=BoF_Males
POP2=CBCommon_Males
OUT=BoF_CBCommon_Males

#Comparison 2: BoFAll_NonCBCommonMales
POP1=BoF_all
POP2=MainlandCommon_males
OUT=BoFAll_NonCBCommonMales

#Comparison 3: CB_Mainland_CommonMales
POP1=CB_CommonMales
POP2=Mainland_CommonMales
OUT=CB_Mainland_CommonMales

#Comparison 4: CBCommon_CBWhite_Males
POP1=CBCommon_males
POP2=CBWhite_males
OUT=CBCommon_CBWhite_Males

#Comparison 5: MainlandCommon_MainlandWhite_Males
POP1=MainlandCommon_males
POP2=MainlandWhite_males
OUT=MainlandCommon_MainlandWhite_Males


vcftools --gzvcf $VCF --not-chr NC_053230.1 --not-chr NC_053233.1 --fst-window-size 50000 --fst-window-step 10000 --weir-fst-pop ${POP1} --weir-fst-pop ${POP2} --out ${OUT}_vcftools_FST

awk '{print $0"\t"NR}' ${OUT}_vcftools_FST.windowed.weir.fst  > ${OUT}_vcftools_FST.windowed.weir.fst.edit
