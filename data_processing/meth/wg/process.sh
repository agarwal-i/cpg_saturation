#!/bin/bash
chr=$1

#awk '{for(i=$2+1;i<=$3;i++) print $1"\t"i-2"\t"i+1}' ../../regions/wg/tmp.chr$chr.bed | sed '1d; $d'| \
#	bedtools getfasta -fi ../../ref/hg19.fa -bed stdin -bedOut | awk '{print $1"\t"$2+1"\t"$3-1"\t"$4}' > tmp.chr$chr.anno1.bed
#wait

#bedtools intersect -a tmp.chr$chr.anno1.bed -b exon.bed | awk '{print $1"\t"$2"\t"$3"\t"$4"\t1"}' > tmp.chr$chr.exon.bed
#bedtools subtract -a tmp.chr$chr.anno1.bed -b exon.bed | awk '{print $1"\t"$2"\t"$3"\t"$4"\t0"}' > tmp.chr$chr.noexon.bed
#wait

#bedtools intersect -a tmp.chr$chr.noexon.bed -b ../sperm.bed -wb | awk '{print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$9}' > tmp.chr$chr.noexon.meth.bed
#bedtools subtract -a tmp.chr$chr.noexon.bed -b ../sperm.bed | awk '{print $0"\tNA"}' > tmp.chr$chr.noexon.nometh.bed
#bedtools intersect -a tmp.chr$chr.exon.bed -b ../sperm.bed -wb | awk '{print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$9}' > tmp.chr$chr.exon.meth.bed
#bedtools subtract -a tmp.chr$chr.exon.bed -b ../sperm.bed | awk '{print $0"\tNA"}' > tmp.chr$chr.exon.nometh.bed
#wait

#cat tmp.chr$chr.noexon.meth.bed tmp.chr$chr.noexon.nometh.bed	tmp.chr$chr.exon.meth.bed tmp.chr$chr.exon.nometh.bed > tmp.chr$chr.anno2.bed

Rscript clean_anno.R $chr
