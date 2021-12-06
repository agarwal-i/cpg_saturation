#!/bin/bash
chr=$1

plink --make-bed --geno --mind --keep include.allanc.list --bed ukb23155_c${chr}_b0_v1.bed --bim UKBexomeOQFE_chr${chr}.bim --fam ukb23155_c${chr}_b0_v1_s200621.fam --out chr${chr}_basic_qcd
