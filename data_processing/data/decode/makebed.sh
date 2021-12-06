#!/bin/bash

bcftools query -f '%CHROM\t%POS\t%REF\t%ALT\n' int/decode.hg19.vcf  > decode.txt
