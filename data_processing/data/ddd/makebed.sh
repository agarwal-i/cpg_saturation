#!/bin/bash

bcftools query -f '%CHROM\t%POS\t%REF\t%ALT\n' int/ddd.hg19.vcf  > ddd.txt
