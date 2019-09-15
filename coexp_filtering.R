#read list of flavonoid/folate, coexpressed & TF
fv<- read.table("fv.txt", header=T, sep="\t", quote="")
ft<- read.table("fv.txt", header=T, sep="\t", quote="")
tf<- read.table("tf_rice.txt", header=T, sep="\t", quote="")
pcc<- read.table("pcc_svr.txt", header=T, sep="\t", quote="")

#combine flavonoid/folate with tf data
fv_tf<- rbind(fv, tf)#ensure col header sama
ft_tf<- rbind(ft, tf)

#filter list of flavonoid/folate, coexpressed & TF
n_fv<- merge(fv, pcc, by="node")
e_fv<- merge(fv, pcc, by="edge")
pcc_fv- unique(rbind(n_fv, e_fv))

#create interaction id rna-seq
pcc_fv$ne_OsID<- paste(pcc_fv$node_OsID, pcc_fv$edge_OsID, sep="_")
pcc_ft$ne_OsID<- paste(pcc_ft$node_OsID, pcc_ft$edge_OsID, sep="_")

****************************************************************************************

#select hub gene
nwk_fv<- read.csv("nwk_analyzer_degree_grn_ft.csv")
nwk_fv<- arrange(ann_nwk_analyzer, desc(Degree, PCC))

****************************************************************************************

#select TF-folate
#create node-edge id
ppan_ft$ne_OsID<- paste(ppan_ft$ft_OsID, ppan_ft$ft_OsID, sep="_")
string_ft$ne_OsID<- paste(string_ft$node_OsID, string_fv$edge_OsID, sep="_")
red_ft$ne_OsID<- paste(red_ft$node_OsID, red_ft$edge_OsID, sep="_")
pcc_ft$ne_OsID<- paste(pcc_ft$node_OsID, pcc_ft$edge_OsID, sep="_")

s<- unique(select(string_ft, ne_OsID))
p<- unique(select(ppan_ft, ne_OsID))
r<- unique(select(red_ft, ne_OsID))
t<- unique(select(pcc_ft, ne_OsID))

s$type="string"
p$type="ppan"
r$type="red"
t$type="rseq"

#create total node-edge id genotype format
grn<- Reduce(function(x,y) merge(x, y, by = "ne_OsID", all.x = TRUE, all.y = TRUE),
                  list(s,p,t,r))

#count uniqe, sharing node-edge id
grn[is.na(grn)]<-"NC"
grn$countNC<- rowSums(grn=="NC")#count occurance of NC
fltr_grn<- filter(grn, countNC == 2)
fltr_grn2<- filter(grn, countNC == 0)
fltr_grn3<- filter(grn, countNC == 1)
ptl_grn<- rbind(fltr_grn, fltr_grn2, fltr_grn3)

****************************************************************************************

#GO analysis
entry_tf<- agrigo_tf %>%
  select(GO_acc, entries) %>%
  cSplit("entries", "// ") %>%
  select_if(~!all(is.na(.))) %>%
  filter(m_tf != " ")

#transform wide to long
t_tf<- t(m_tf)
df_tf<- as.data.frame(t_tf)
df_tf[]<- lapply(df_tf, as.character)
colnames(df_tf)<- df_tf[1, ]
df_tf<- df_tf[-1 ,]
lst_tf<- df_tf %>% gather(df_tf, OsID, 1:141, na.rm=FALSE)
clean_go_tf<- filter(lst_tf, OsID!="nc")
write.table(clean_go_tf, "enr_go_reactome/clean_go_tf.txt", col.names=T, row.names=F, sep="\t", quote=F)

# split, mutate & unnest- turn column into row by row
r_ft<-folate_reactome %>%
  mutate(OsID=strsplit(as.character(OsID), ";")) %>%
  unnest(OsID)

