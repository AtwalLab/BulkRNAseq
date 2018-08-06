
# Construct expression matrix from Kallisto abundance results 

sample_name<-list.files(path="./output/kallisto",pattern="abundance")
label<-gsub("_S.*","",sample_name)

for (i in 1:length(sample_name)){
  abundance<-read.delim(paste(sample_name[i],"/","abundance.tsv",sep=""))
  abundance[,2:4]<-NULL
  colnames(abundance)<-c("transcript",label[i])
  if (i==1){
    expression<-abundance
  } else {
    expression<-cbind(expression,abundance[,2,drop=F])  
  }
}

write.table(expression,"expression_matrix_pre_batch_correct.txt",quote = F,sep="\t",row.names = F)
write.table(expression,"output/expression_matrix_pre_batch_correct.txt",quote = F,sep="\t",row.names = F)
