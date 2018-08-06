# BulkRNAseq

BulkRNAseq provides a simplified pipeline to analyze bulk RNAseq data.
The script consists mainly of :

1) "kallisto quant" for running Kallisto quantification of transcript abundance
2) "sleuthAnalysis.R" for running Sleuth differential analysis
3) "combat.R" for running ComBat batch correction
4) "ggbiplot.R" for running principal component analysis

Get the pipeline run by simply :
source BulkRNAseq.sh

References and installations :
https://pachterlab.github.io/kallisto/
https://pachterlab.github.io/sleuth/
https://www.bu.edu/jlab/wp-assets/ComBat/Abstract.html
https://github.com/vqv/ggbiplot
