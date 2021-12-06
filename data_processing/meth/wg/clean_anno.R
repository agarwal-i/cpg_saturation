library(data.table)
args = commandArgs(TRUE)

# read in main anno file
df = fread(file=paste0("tmp.chr", args[1],".anno2.bed"), header=FALSE)
colnames(df) = c("CHR", "start","end","ref_context", "flag.exon","meth.sperm")

tmp = fread(file=paste0("tmp.ovary.chr", args[1],".bed"), header=FALSE)
colnames(tmp) = c("CHR","end","meth.ovary")
tmp = unique(tmp)
df = merge(df, tmp, all.x=TRUE, by=c("CHR","end"))

df$meth.sperm=as.numeric(round(df$meth.sperm,2))
df$meth.ovary=as.numeric(round(df$meth.ovary,2))

# clean mut
	df$ref_context <- toupper(df$ref_context)
      	df$focal <- substr(df$ref_context,2,2)
      	df$context_3 <- substr(df$ref_context,3,3)
      	df$context_5 <- substr(df$ref_context,1,1)
	df <- df[df$focal %in% c("A","C","G","T") & df$context_5 %in% c("A","C","G","T") & df$context_3 %in% c("A","C","G","T"),] # DROP

        # Recreate CHR level freq table with 192 mut types collapsed into ntest.

	df.1 <- df[df$focal %in% c("A","G"),]
        df.1$check_c5 = df.1$context_5
        df.1$check_c3 = df.1$context_3
        df.1$context_5 = ifelse(df.1$check_c3=="A","T",
                                         ifelse(df.1$check_c3=="C","G",
                                                ifelse(df.1$check_c3=="T","A",
                                                       ifelse(df.1$check_c3=="G","C","NA"))))
        df.1$context_3 = ifelse(df.1$check_c5=="A","T",
                                         ifelse(df.1$check_c5=="C","G",
                                                ifelse(df.1$check_c5=="T","A",
                                                       ifelse(df.1$check_c5=="G","C","NA"))))

	df.1$focal = ifelse(df.1$focal=="A","T",
                          ifelse(df.1$focal=="G","C","NA"))
        df.1$check_c5 <- NULL
        df.1$check_c3 <- NULL

        df.2 <- df[df$focal %in% c("C","T"),]
        df <- rbind(df.1, df.2)
        rm(df.1,df.2)

        df$site <- paste0(df$context_5, df$focal, df$context_3)

tmp = fread(file=paste0("../../data/decode/decode.txt"), header=F)[,1:2]
colnames(tmp) = c("CHR","end")
tmp = unique(tmp)
tmp = merge(df, tmp, all.y=TRUE, by=c("CHR","end"))
tmp=tmp[CHR==paste0("chr",args[1])]
write.table(tmp, file=paste0("chr", args[1],".decode.out"), sep="\t", row.names=F, col.names=F, quote=F)

df$count = 1
df = df[, lapply(.SD, sum, na.rm=TRUE), by=list(meth.sperm,meth.ovary, flag.exon, site), .SDcols=c(grep("count",colnames(df)))]
write.table(df, file=paste0("sites.chr", args[1],".meth.out"), sep="\t", row.names=F, col.names=F, quote=F)



