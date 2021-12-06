#!/bin/bash

# download
#wget http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.wgs.phase3_shapeit2_mvncall_integrated_v5c.20130502.sites.vcf.gz
#wget http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.wgs.phase3_shapeit2_mvncall_integrated_v5c.20130502.sites.vcf.gz.tbi

#wait
#mv ALL.wgs.phase3_shapeit2_mvncall_integrated_v5c.20130502.sites.vcf.gz* raw/

#liftover
#source process.sh 
#wait
#bgzip int/1000g.hg19.vcf
#tabix  #bgzip int/1000g.hg19.vcf.gz

#output
bcftools view -f PASS -T ../../anno/anno.regions.bed int/1000g.hg19.vcf.gz -Ou | bcftools norm -m- |\
	bcftools query -f '%CHROM\t%POS\t%REF\t%ALT\t%AN\t%AF\t%EUR_AF\t%AFR_AF\t%AMR_AF\n' | awk '{print $0 >> $1".txt"}'
