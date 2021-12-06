#!/bin/bash

bcftools query -f '%CHROM\t%POS\t%REF\t%ALT\t%CLNSIG\n' clinvar.vcf.gz | awk '{print "chr"$0}' > clinvar.txt
