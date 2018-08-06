
# Compute and plot the principal components

pca <- read.delim("output/expression_matrix_post_batch_correct.txt",header=T,row.names=1)
pca <- scale(t(log2(pca+1))) # shift to pca+5000 if getting NaN warnings
pca.pca <- prcomp(pca, scale. = TRUE)

mod <- read.delim("model_matrix.txt",header=T,row.names=NULL)
pca.class <- as.vector(mod$Covariate1) 
pca.class <- factor(pca.class)

pca.labels <- as.vector(mod$Sample.name)
pca.labels <- factor(pca.labels)

library(ggbiplot)

pdf("output/pc12.pdf")

ggbiplot(pca.pca, choices = c(1,2), obs.scale = 1, var.scale = 1,groups = pca.class, ellipse = TRUE, circle = FALSE,var.axes=FALSE,labels=pca.labels)+
scale_color_manual(name="condition", values=c("purple", "red", "darkgreen","blue"))
#  +geom_point(aes(colour=pca.class),size = 1)

dev.off()

pdf("output/pc23.pdf")

ggbiplot(pca.pca, choices = c(2,3), obs.scale = 1, var.scale = 1,groups = pca.class, ellipse = TRUE, circle = FALSE,var.axes=FALSE,labels=pca.labels)+
  scale_color_manual(name="condition", values=c("purple", "red", "darkgreen","blue"))
#  +geom_point(aes(colour=pca.class),size = 1)

dev.off()

pdf("output/pc13.pdf")

ggbiplot(pca.pca, choices = c(1,3), obs.scale = 1, var.scale = 1,groups = pca.class, ellipse = TRUE, circle = FALSE,var.axes=FALSE,labels=pca.labels)+
  scale_color_manual(name="condition", values=c("purple", "red", "darkgreen","blue"))
#  +geom_point(aes(colour=pca.class),size = 1)

dev.off()