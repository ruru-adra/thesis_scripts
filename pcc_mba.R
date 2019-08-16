#read data gene expression with FPKM values
fmt_pcc<- read.table("fmt_for_pcc.txt", header=T, sep="\t", row.names = 1)

#create function pcc
flat_corr_mat<- function(cor_r, cor_p){
  library(tidyr)
  library(tibble)
  cor_r<- rownames_to_column(as.data.frame(cor_r), var= "row")
  cor_r<- gather(cor_r, column, cor, -1)
  cor_p<- rownames_to_column(as.data.frame(cor_p), var= "row")
  cor_p<- gather(cor_p, column, p, -1)
  cor_p_matrix<- left_join(cor_r, cor_p, by=c("row", "column"))
  cor_p_matrix
}

corr_max<- rcorr(as.matrix(fmt_pcc[, 1:1394])) #calc corr(r) & pvalue(p)

out_pcc<- flat_corr_mat(corr_max$r, corr_max$P) #to view in table

pcc_r0.7<- filter(out_pcc, cor >= 0.7) #filter correlation value
