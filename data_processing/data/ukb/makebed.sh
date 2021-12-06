#!/bin/bash
chr=$1

bcftools query -f '%CHROM\t%POS\t%REF\t%ALT\t%AN\t%AF\n' int/chr$chr.hg19.vcf  > chr$chr.txt
