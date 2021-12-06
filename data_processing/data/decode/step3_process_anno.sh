#!/bin/bash

infile=int/decode.hg19.anno.gz

bcftools view $infile |\
bcftools +split-vep -f %CHROM"\t"%POS"\t"%REF"\t"%ALT"\t"%BIOTYPE"\t"%Feature"\t"%SYMBOL"\t"%CANONICAL"\t"%LoF"\t"%ID"\t"%Consequence'\n' -d -a CSQ |\
awk '{if ($5=="protein_coding" && $8=="YES") print $0}' > int/decode.csq

