#!/bin/bash
# export CLOUDSDK_PYTHON=python
# #gsutil -m cp gs://gcp-public-data--gnomad/release/2.1.1/vcf/exomes/gnomad.exomes.r2.1.1.sites.* .

chr=$1
bcftools view -f PASS raw/gnomad.exomes.r2.1.1.sites.$chr.vcf.bgz |\
bcftools +split-vep -f %CHROM"\t"%POS"\t"%REF"\t"%ALT"\t"%BIOTYPE"\t"%Feature"\t"%SYMBOL"\t"%CANONICAL"\t"%LoF"\t"%AC_nfe"\t"%AF_nfe"\t"%AN_nfe"\t"%AF"\t"%AN"\t"%AC"\t"%controls_AC_nfe"\t"%controls_AN_nfe"\t"%controls_AF_nfe"\t"%Consequence'\n' -d -a vep |\
awk '{if ($5=="protein_coding" && $8=="YES") print}' | bgzip > freq.chr$chr.txt.gz


#bcftools view -f PASS gnomad.exomes.r2.1.sites.chr1.vcf.bgz |\
#bcftools +split-vep -f %CHROM"\t"%POS"\t"%REF"\t"%ALT"\t"%BIOTYPE"\t"%Feature"\t"%SYMBOL"\t"%CANONICAL"\t"%LoF"\t"%AC_nfe"\t"%AF_nfe"\t"%AN_nfe"\t"%Consequence'\n' -d -a vep |\
#awk '{if ($5=="protein_coding" && $8=="YES") print}' > freq3.chr$chr.txt 
