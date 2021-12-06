#!/bin/bash

java -Xmx6g -jar $PICARD LiftoverVcf I=raw/GHS_Freeze_50.L3DP10.pVCF.frq.vcf.gz \
	O=int/ghs.hg19.vcf \
	CHAIN=../../software/b37tohg19.chain \
	REJECT=int/ghs.rejected_variants.vcf \
	R=../../ref/hg19/hg19.fa \
	MAX_RECORDS_IN_RAM=100000

