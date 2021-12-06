library(data.table)
args = commandArgs(TRUE)

# read in main anno file
df = fread(file=paste0("int/tmp.chr", args[1],"_", args[2],".anno.gz"), header=FALSE)
colnames(df) = c("CHR", "Pos","Ref", "Alt","BIOTYPE","Feature","SYMBOL","CANONICAL","LoF","ref_context","cadd_raw","cadd_phred","EXON","protein_position","csq")
df = df[, .(csq = unlist(tstrsplit(csq, "&", fixed=TRUE))), by=c("CHR", "Pos","Ref", "Alt","Feature","SYMBOL","CANONICAL","cadd_phred","LoF","ref_context","EXON","protein_position")][!is.na(csq)]

#import rank file
ranks=fread("vep.ranks", header=F)
colnames(ranks)=c("csq","rank")

# for each variant make column with worst position
df = merge(df, ranks, by=c("csq"), all.x=T)
df = df[, min:=min(as.numeric(rank)), by=c("CHR", "Pos", "Ref", "Alt")]
colnames(ranks)=c("csq_worst","min")
df = merge(df, ranks, by=c("min"), all.x=T)

# make column with randomly picked canonical
df = unique(df[CANONICAL=="YES"])
df = df[, csq_list:=toString(unique(csq)),by = list(CHR,Pos, Ref, Alt)]
set.seed(10)
df=df[df[ , .I[sample(.N,1)] , by = list(CHR,Pos, Ref, Alt)]$V1]

# contract per variant
df = unique(df[,c("CHR", "Pos","Ref", "Alt","Feature","SYMBOL","LoF","ref_context","EXON","protein_position","cadd_raw","cadd_phred","csq","csq_list","csq_worst")])

# check no duplicates
df = df[,id:=.N, by=list(CHR,Pos, Ref, Alt)]
table(df$id)

#bval
anno = unique(fread(paste0("int/tmp.chr",args[1],".bstat.bed"), header=F))
colnames(anno)=c("CHR","Pos","bval")
df=merge(df,anno, by=c("CHR", "Pos"), all.x=T)

#add methylation level
anno = unique(fread(paste0("int/tmp.chr",args[1],".ovary.bed"), header=F))
colnames(anno)=c("CHR","Pos","cpg.meth.ovary")
df=merge(df, anno, by=c("CHR", "Pos"), all.x=T)

anno = unique(fread(paste0("int/tmp.chr",args[1],".sperm.bed"), header=F))
colnames(anno)=c("CHR","Pos","cpg.meth.sperm")
df=merge(df, anno, by=c("CHR", "Pos"), all.x=T)

# add region flag ukb wes
anno = unique(fread(paste0("int/tmp.chr",args[1],".ukbden.bed"), header=F))
colnames(anno)=c("CHR","Pos","flag.ukbden")
df=merge(df, anno, by=c("CHR", "Pos"), all.x=T)

# add gnomad wes flag
anno = unique(fread(paste0("int/tmp.chr",args[1],".gnden.bed"), header=F))
colnames(anno)=c("CHR","Pos","flag.gnden")
df=merge(df, anno, by=c("CHR", "Pos"), all.x=T)

# protein positions and dup handling
anno = unique(fread("../prot_func/prot_final.bed", header=F))[,c(1,2,6,7,8)]
colnames(anno)=c("CHR","Pos","domain","domain_all","note_all")
df=merge(df, anno, by=c("CHR", "Pos"), all.x=T)

# clean mut
        df$mut <- paste(df$Ref,df$Alt, sep=">")
	df$ref_context <- toupper(df$ref_context)
      	df$context_3 <- substr(df$ref_context,3,3)
      	df$context_5 <- substr(df$ref_context,1,1)
	df <- df[df$context_5 %in% c("A","C","G","T") & df$context_3 %in% c("A","C","G","T"),] # DROP

        # Recreate CHR level freq table with 192 mut types collapsed into ntest.
        # Collapse c("A>T","A>C","A>G","G>A","G>T","G>C") into c("C>T","C>A","C>G","T>A","T>G","T>C")

	df.1 <- df[df$mut %in% c("A>T","A>C","A>G","G>A","G>T","G>C"),]
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
        df.1$mut = ifelse(df.1$mut=="A>T","T>A",
                                   ifelse(df.1$mut=="A>C","T>G",
                                          ifelse(df.1$mut=="A>G","T>C",
                                                 ifelse(df.1$mut=="G>A","C>T",
                                                        ifelse(df.1$mut=="G>T","C>A",
                                                               ifelse(df.1$mut=="G>C","C>G","NA"))))))

        df.1$check_c5 <- NULL
        df.1$check_c3 <- NULL

        df.2 <- df[df$mut %in% c("C>T","C>A","C>G","T>A","T>G","T>C"),]
        df <- rbind(df.1, df.2)
        rm(df.1,df.2)

        df$site <- ifelse(df$context_3=="G" & substr(df$mut,1,1)=="C","CpG", substr(df$mut,1,1))

head(df)
write.table(df, file=paste0("int/tmp.chr", args[1],"_", args[2],".out"), sep="\t", row.names=F, col.names=F, quote=F)
