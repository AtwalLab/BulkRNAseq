
# Correct the expression matrix for batch effects

library(sva)

sample_name<-list.files(path=".",pattern=glob2rx("expression*txt"))
data <- read.delim(sample_name,header=T,row.names=1)

data$rowsum<-rowSums(data)
data <- subset(data,rowsum != 0)
data$rowsum <- NULL
data <- log2(data+1)

pheno <- read.delim("model_matrix.txt",header=T,row.names=1)
batch = pheno$Batch
modcombat=model.matrix(~Covariate1,pheno)

combat_edata=ComBat(dat=data,batch=batch,mod=modcombat,par.prior=TRUE)
combat_edata <- 2^(combat_edata)-1

combat_edata[combat_edata<0]<-0
write.table(combat_edata,"output/expression_matrix_post_batch_correct.txt", quote = FALSE, sep = '\t')
