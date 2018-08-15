# BulkRNAseq

BulkRNAseq provides a simplified pipeline to analyze bulk RNAseq data.

The script consists mainly of :
1) "kallisto quant" for running Kallisto quantification of transcript abundance
2) "sleuthAnalysis.R" for running Sleuth differential analysis
3) "combat.R" for running ComBat batch correction
4) "ggbiplot.R" for running principal component analysis

Inputs (placed in the same directory as the source codes) :
*skip to step #4 if the expression marix is already available*
1) Raw sequence fastq files ".fastq.gz"
2) Specify fragment length and its uncertainty, number of bootsraps and threads
4) Samples covariates and batches information in a file named "model_matrix.txt"
4) Expression matrix in ".txt" with column as samples x row as transcripts or genes (filename must contain the word "expression") 

Get the pipeline run directly on terminal by :
" source BulkRNAseq.sh "

References and installations (including system requirments and dependencies) :  
Kallisto -> https://pachterlab.github.io/kallisto/  
Sleuth -> https://pachterlab.github.io/sleuth/  
ComBat -> https://www.bu.edu/jlab/wp-assets/ComBat/Abstract.html  
ggbiplot -> https://github.com/vqv/ggbiplot 
