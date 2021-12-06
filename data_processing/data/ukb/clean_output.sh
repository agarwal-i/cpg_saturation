#!/bin/bash
chr=$1

cat int/anno.chr$chr |\
sed '/^#/d' |\
awk '{print $1"\t"$2-1"\t"$2"\t"$4"\t"$5"\t"$8"\t"$3}' |\
sort -k 1,1 -k2,2n | awk '{print $0 > "out/ukb."$1".hg19.bed"}'

wait
Rscript get_list.R $chr

wait
plink --recode vcf bgz --real-ref-alleles --bed raw/ukb23155_c${chr}_b0_v1.bed --bim raw/UKBexomeOQFE_chr${chr}.bim --fam raw/ukb23155_c${chr}_b0_v1_s200621.fam --extract out/chr${chr}.snps --out out/chr$chr
