#!/bin/bash
chr=$1

infile=int/chr$chr.anno.gz

bcftools view -T ../../regions/ukb.regions.hg19.bed $infile |\
bcftools +split-vep -f %CHROM"\t"%POS"\t"%REF"\t"%ALT"\t"%BIOTYPE"\t"%Feature"\t"%SYMBOL"\t"%CANONICAL"\t"%LoF"\t"%ID"\t"%EXON"\t"%Protein_position"\t"%Consequence'\n' -d -a CSQ |\
awk '{if ($5=="protein_coding" && $8=="YES" && $13~"synonymous_variant" && $13!~"splice") print $1"\t"$2"\t"$3"\t"$4"\t"$6"\t"$7"\t"$10"\t"$13}' > int/chr$chr.syn.list

wait
awk '{print $7}' int/chr$chr.syn.list | uniq  >> int/syn.all.snps

