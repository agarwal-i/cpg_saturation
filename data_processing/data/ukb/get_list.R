library(data.table)
args = commandArgs(trailingOnly=TRUE)

df=fread(paste0("out/ukb.chr",args[1],".hg19.bed"), header=F)
colnames(df)=c("CHROM","start","POS","ref","alt","info","ID")

hc_lof= fread(paste0("int/all.lof.bed.gz"), header=F)
colnames(hc_lof)=c("CHROM","start","POS","ref","alt","gene_ID","SYMBOL")

df=merge(df, hc_lof, by=c("CHROM","start","POS","ref","alt"))
df=unique(df[,c("ID")])
write.table(df, file=paste0("out/chr",args[1],".snps"), sep="\t", quote=F, row.names=F, col.names=F)
