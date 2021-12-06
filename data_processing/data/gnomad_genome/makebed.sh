#!/bin/bash
chr=$1

bcftools view -f PASS -T ../../anno/anno.regions_nochr.bed raw/gnomad.genomes.r2.1.1.sites.$chr.vcf.bgz -Ou | bcftools query -f '%CHROM\t%POS\t%REF\t%ALT\t%AN\t%AF\tAN_nfe\t%AF_nfe\n' | awk '{print "chr"$0}' > chr$chr.txt
