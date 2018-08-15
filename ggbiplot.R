
# Compute and plot the principal components

sample_name_pre_batch<-list.files(path=".",pattern=glob2rx("expression*txt"))
sample_name_post_batch<-list.files(path="./output",pattern=glob2rx("expression*post*txt"))

mod <- read.delim("model_matrix.txt",header=T,row.names=NULL)
pca.class <- as.vector(mod$Covariate1) 
pca.class <- factor(pca.class)

pca.labels <- as.vector(mod$Sample.name)
pca.labels <- factor(pca.labels)

library(ggbiplot)
library(gridExtra)

for (i in 1:2){

  if (i == 1){
    pca <- read.delim(sample_name_pre_batch,header=T,row.names=1)
    pca$rowsum<-rowSums(pca)
    pca <- subset(pca,rowsum != 0)
    pca$rowsum <- NULL
  }
  else {
    pca <- read.delim(paste("output/",sample_name_post_batch,sep=""),header=T,row.names=1)
  }
  pca <- scale(t(log2(pca+1))) # shift to pca+5000 if getting NaN warnings
  pca.pca <- prcomp(pca, scale. = TRUE)

  if (i == 1){
    pdf("output/pc_pre_batch.pdf")
    pc12<-ggbiplot(pca.pca, choices = c(1,2), obs.scale = 1, var.scale = 1,groups = pca.class, ellipse = TRUE, circle = FALSE,var.axes=FALSE,labels=pca.labels)+
      scale_color_manual(name="condition", values=c("purple", "red", "darkgreen","blue"))
    #  +geom_point(aes(colour=pca.class),size = 1)
    
    pc23<-ggbiplot(pca.pca, choices = c(2,3), obs.scale = 1, var.scale = 1,groups = pca.class, ellipse = TRUE, circle = FALSE,var.axes=FALSE,labels=pca.labels)+
      scale_color_manual(name="condition", values=c("purple", "red", "darkgreen","blue"))
    #  +geom_point(aes(colour=pca.class),size = 1)
    
    pc13<-ggbiplot(pca.pca, choices = c(1,3), obs.scale = 1, var.scale = 1,groups = pca.class, ellipse = TRUE, circle = FALSE,var.axes=FALSE,labels=pca.labels)+
      scale_color_manual(name="condition", values=c("purple", "red", "darkgreen","blue"))
    #  +geom_point(aes(colour=pca.class),size = 1)
  }
  else {
    pdf("output/pc_post_batch.pdf")
    pc12<-ggbiplot(pca.pca, choices = c(1,2), obs.scale = 1, var.scale = 1,groups = pca.class, ellipse = TRUE, circle = FALSE,var.axes=FALSE,labels=pca.labels)+
      scale_color_manual(name="condition", values=c("purple", "red", "darkgreen","blue"))
    #  +geom_point(aes(colour=pca.class),size = 1)

    pc23<-ggbiplot(pca.pca, choices = c(2,3), obs.scale = 1, var.scale = 1,groups = pca.class, ellipse = TRUE, circle = FALSE,var.axes=FALSE,labels=pca.labels)+
      scale_color_manual(name="condition", values=c("purple", "red", "darkgreen","blue"))
    #  +geom_point(aes(colour=pca.class),size = 1)

    pc13<-ggbiplot(pca.pca, choices = c(1,3), obs.scale = 1, var.scale = 1,groups = pca.class, ellipse = TRUE, circle = FALSE,var.axes=FALSE,labels=pca.labels)+
      scale_color_manual(name="condition", values=c("purple", "red", "darkgreen","blue"))
    #  +geom_point(aes(colour=pca.class),size = 1)
  }
  grid.arrange(pc12,pc23,pc13)
  dev.off()
}
