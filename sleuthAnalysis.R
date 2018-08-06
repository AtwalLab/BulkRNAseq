
# Perform differential analysis on Kallisto results

library("sleuth")
args = commandArgs(trailingOnly=TRUE)

options(mc.cores=4L)

base_dir <- "./output"

sample_id <- dir(file.path(base_dir,"kallisto"))

kal_dirs <- sapply(sample_id, function(id) file.path(base_dir, "kallisto", id))

s2c <- read.table(file.path(base_dir, "model_matrix.txt"), header = TRUE, stringsAsFactors=FALSE)

#s2c <- dplyr::select(s2c, sample = experiment, condition, pn = number)
#s2c <- dplyr::select(s2c, sample = experiment, condition, ba = batch)
s2c <- dplyr::select(s2c, sample = experiment, condition, pn = number, ba = batch)
s2c <- dplyr::mutate(s2c, path = kal_dirs)

mart <- biomaRt::useMart(biomart = "ENSEMBL_MART_ENSEMBL",dataset = "hsapiens_gene_ensembl", host = 'www.ensembl.org')
t2g <- biomaRt::getBM(attributes = c("ensembl_transcript_id", "ensembl_gene_id", "external_gene_name"), mart = mart)
t2g <- dplyr::rename(t2g, target_id = ensembl_transcript_id, ens_gene = ensembl_gene_id, ext_gene = external_gene_name)

#so <- sleuth_prep(s2c, ~condition, target_mapping=t2g, aggregation_column='ens_gene')
#so <- sleuth_prep(s2c, ~condition + pn, target_mapping=t2g, aggregation_column='ens_gene')
#so <- sleuth_prep(s2c, ~condition + ba, target_mapping=t2g, aggregation_column='ens_gene')
so <- sleuth_prep(s2c, ~condition + pn + ba, target_mapping=t2g, aggregation_column='ens_gene')
so <- sleuth_fit(so)

#so <- sleuth_fit(so, ~1, 'reduced')
#so <- sleuth_fit(so, ~pn, 'reduced')
#so <- sleuth_fit(so, ~ba, 'reduced')
so <- sleuth_fit(so, ~pn+ba,'reduced')

#so <- sleuth_wt(so, which_beta='reduced', which_model='full')
# Prim_Met
#so <- sleuth_wt(so, which_beta=paste("condition",args[1],sep=''), which_model='full') 
# Norm_Prim
so <- sleuth_wt(so, which_beta=paste("condition",args[2],sep=''), which_model='full')

# Prim_Met
#results_table <- sleuth_results(so,paste("condition",args[1],sep=''),test_type='wt',which_model='full',rename_cols=TRUE,show_all=TRUE)
# Norm_Prim
results_table <- sleuth_results(so,paste("condition",args[2],sep=''),test_type='wt',which_model='full',rename_cols=TRUE,show_all=TRUE)

write.table(results_table,'sleuth_results.txt', quote = FALSE, sep = '\t', row.names=FALSE)
