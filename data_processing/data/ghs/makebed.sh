#!/bin/bash

#liftover
#source process.sh 
#wait

#output
bcftools view -T ../../prot_func/regions.bed int/ghs.hg19.vcf | bcftools query -f '%CHROM\t%POS\t%REF\t%ALT\n' | awk '{print $0 >> $1".txt"}'
