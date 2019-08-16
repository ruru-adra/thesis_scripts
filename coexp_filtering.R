#create node-edge id
ppan_fv$ne_OsID<- paste(ppan_fv$fv_OsID, ppan_fv$tf_OsID, sep="_")
string_fv$ne_OsID<- paste(string_fv$node_OsID, string_fv$edge_OsID, sep="_")
red_fv$ne_OsID<- paste(string_fv$node_OsID, string_fv$edge_OsID, sep="_")

s<- unique(select(string_fv, ne_OsID))
p<- unique(select(ppan_fv, ne_OsID))
r<- unique(select(red_fv, ne_OsID))

s$type="string"
p$type="ppan"
r$type="red"

#create total node-edge id genotype format
grn_fv<- Reduce(function(x,y) merge(x, y, by = "ne_OsID", all.x = TRUE, all.y = TRUE),
                  list(s,p,c,r))

#count uniqe, sharing node-edge id
grn<- grn_fv
grn[is.na(grn)]<-"NC"
grn$countNC<- rowSums(grn=="NC")#count occurance of NC
fltr_grn<- filter(grn, countNC == 2)
fltr_grn2<- filter(grn, countNC == 0)
fltr_grn3<- filter(grn, countNC == 1)
ptl_grn<- rbind(fltr_grn, fltr_grn2, fltr_grn3)

