#!/bin/bash
chr=$1

infile=int/chr$chr.anno.gz

bcftools view -T ../../regions/ukb.regions.hg19.bed $infile |\
bcftools +split-vep -f %CHROM"\t"%POS"\t"%REF"\t"%ALT"\t"%BIOTYPE"\t"%Feature"\t"%SYMBOL"\t"%CANONICAL"\t"AF"\t"%LoF"\t"%ID"\t"%AN"\t"%Consequence'\n' -d -a CSQ |\
awk '{if ($5=="protein_coding" && $8=="YES") print $1"\t"$2"\t"$3"\t"$4"\t"$6"\t"$7"\t"$11"\t"$14"\t"$9"\t"$13}' > int/test.chr$chr.lof.all.list

wait
grep -E "stop_gained|splice_acceptor|splice_donor|frameshift" int/test.chr$chr.lof.all.list | awk '{print $7}' | uniq  >> int/test.lof.all.snps

