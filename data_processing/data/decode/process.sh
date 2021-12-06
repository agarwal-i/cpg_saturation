#!/bin/bash

Rscript makevcf.R raw/aau1043_DataS5_revision1.tsv
wait

java -Xmx6g -jar $PICARD LiftoverVcf I=int/decode.hg38.vcf \
        O=int/decode.hg19.vcf \
        CHAIN=../../../software/hg38ToHg19.over.chain \
        REJECT=int/rejected_variants.vcf \
        R=../../ref/hg19.fa \
        MAX_RECORDS_IN_RAM=100000 \
        WARN_ON_MISSING_CONTIG=true

wait
source makebed.sh
