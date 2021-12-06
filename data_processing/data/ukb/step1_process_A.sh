#!/bin/bash
chr=$1

plink --freq --keep raw/include.allanc.list --real-ref-alleles --bed raw/ukb23155_c${chr}_b0_v1.bed --bim raw/UKBexomeOQFE_chr${chr}.bim --fam raw/ukb23155_c${chr}_b0_v1_s200621.fam --out int/chr${chr}
wait

cat int/chr$chr.frq | awk '{split($2,temp,":"); $7=temp[2];}1' |\
awk 'BEGIN {print "##fileformat=VCFv4.2\n\
##source=PLINKv1.90\n\
##INFO=<ID=AF,Number=.,Type=Float,Description=\"Allele Frequency\">\n\
##INFO=<ID=AN,Number=1,Type=Integer,Description=\"Allelic Depth\">\n\
#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO"
}
NR>1{print "chr"$1"\t"$7"\t"$2"\t"$4"\t"$3"\t.\t.\tAF="$5";AN="$6}' > int/chr$chr.hg38.vcf
wait

java -Xmx6g -jar $PICARD LiftoverVcf I=int/chr$chr.hg38.vcf \
	O=int/chr$chr.hg19.vcf \
	CHAIN=../../../software/hg38ToHg19.over.chain \
	REJECT=int/chr$chr.rejected_variants.vcf \
	R=../../ref/hg19.fa \
	MAX_RECORDS_IN_RAM=100000 \
	WARN_ON_MISSING_CONTIG=true

