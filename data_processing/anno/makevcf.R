library(data.table)
args = commandArgs(TRUE)

df = fread(file=args[1], header=FALSE)
df=rbind(df,df,df)
colnames(df) = c("CHROM","start","end","context")

df$context = toupper(df$context)
df$ref = substr(df$context,2,2)
df=df[order(CHROM,start),]
df = df[, id:=seq(.N), by=c("CHROM","start","end","ref","context")]

df$alt = ifelse(df$ref=="A" & df$id==1,"C",
	 ifelse(df$ref=="A" & df$id==2,"T",
	 ifelse(df$ref=="A" & df$id==3,"G",
		ifelse(df$ref=="C" & df$id==1,"A",
		ifelse(df$ref=="C" & df$id==2,"T",
                ifelse(df$ref=="C" & df$id==3,"G",
			ifelse(df$ref=="T" & df$id==1,"A",
			ifelse(df$ref=="T" & df$id==2,"C",
                	ifelse(df$ref=="T" & df$id==3,"G",
				ifelse(df$ref=="G" & df$id==1,"A",
				ifelse(df$ref=="G" & df$id==2,"T",
                		ifelse(df$ref=="G" & df$id==3,"C","error"))))))))))))

df=df[!alt=="error"]
df=df[,c("CHROM","end","context","ref","alt")]
cat("##fileformat=VCFv4.2\n#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\n", file=args[2])
write.table(df, file=args[2], sep="\t", row.names=F, col.names=F, quote=F, append=TRUE)
