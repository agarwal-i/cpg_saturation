#!/bin/bash
chr=$1

Rscript saturation.process.R $chr
wait
Rscript gen_lookup.R
wait
Rscript sat.group.R $chr

wait
gzip -f out/distcadd.chr$chr.out
gzip -f out/distbval.chr$chr.out
gzip -f out/mecpgti.all.chr$chr.out
