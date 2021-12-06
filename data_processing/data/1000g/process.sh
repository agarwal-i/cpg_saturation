#!/bin/bash

java -Xmx6g -jar $PICARD LiftoverVcf I=raw/ALL.wgs.phase3_shapeit2_mvncall_integrated_v5c.20130502.sites.vcf.gz \
	O=int/1000g.hg19.vcf \
	CHAIN=../../../software/b37tohg19.chain \
	REJECT=int/1000.rejected_variants.vcf \
	R=../../ref/hg19.fa \
	MAX_RECORDS_IN_RAM=100000

