library(data.table)
args = commandArgs(TRUE)

df = fread(file=args[1], header=FALSE, skip=12)[,c(1:5)]
colnames(df) = c("CHROM","end","ref","alt","proband_id")
df$QUAL=df$FILTER=df$INFO="."
df=df[,c("CHROM","end","proband_id","ref","alt","QUAL","FILTER","INFO")]
cat("##fileformat=VCFv4.2\n#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\n", file="int/decode.hg38.vcf")
write.table(df, file="int/decode.hg38.vcf", sep="\t", row.names=F, col.names=F, quote=F, append=TRUE)
