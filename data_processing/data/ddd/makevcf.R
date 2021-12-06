library(data.table)
args = commandArgs(TRUE)

df = fread(file=args[1], header=T)[,c(1:5)]
colnames(df) = c("proband_id","CHROM","end","ref","alt")
df$CHROM = paste0("chr",df$CHROM)
df$QUAL=df$FILTER=df$INFO="."
df=df[,c("CHROM","end","proband_id","ref","alt","QUAL","FILTER","INFO")]
cat("##fileformat=VCFv4.2\n#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\n", file="int/ddd.hg38.vcf")
write.table(df, file="int/ddd.hg19.vcf", sep="\t", row.names=F, col.names=F, quote=F, append=TRUE)
