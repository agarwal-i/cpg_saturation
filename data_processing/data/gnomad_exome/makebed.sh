#!/bin/bash
chr=$1

bcftools view -f PASS -T regions.bed raw/gnomad.exomes.r2.1.1.sites.$chr.vcf.bgz | bcftools query -f '%CHROM\t%POS\t%REF\t%ALT\t%AN\t%AF\t%AN_nfe\t%AF_nfe\n' | awk '{print "chr"$0}' > chr$chr.txt
