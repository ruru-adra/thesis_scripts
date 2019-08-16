#read table
snp_bali<- read.table("./data/finalSNP_bali.txt", header=T, sep="\t")
snp_ph<- read.table("./data/finalSNP_ph.txt", header=T, sep="\t")
snp_mrm16<- read.table("./data/finalSNP_mrm16.txt", header=T, sep="\t")
snp_q100<- read.table("./data/finalSNP_q100.txt", header=T, sep="\t")
snp_mr297<- read.table("./data/finalSNP_mr297.txt", header=T, sep="\t")
snp_q76<- read.table("./data/finalSNP_q76.txt", header=T, sep="\t")

#count SNP distance
bali$diff<- ave(bali$pos, factor(bali$chr), FUN=function(x) c(NA, diff(x)))
bali_qual<- filter(bali, diff >= 150)

#select unique & specific column
a_bali<- unique(select(snp_bali, snp_id, ref,alel))
a_ph<- unique(select(snp_ph, snp_id, ref,alel))
a_mr<- unique(select(snp_mrm16, snp_id, ref,alel))
a_qr<- unique(select(snp_q100, snp_id, ref,alel))
a_mw<- unique(select(snp_mr297, snp_id, ref,alel))
a_qw<- unique(select(snp_q76, snp_id, ref,alel))

#filter genic snps with diff pos
g_bali<- filter(g_bali, effect %in% c("missense_variant", "synonymous_variant", "3_prime_UTR_variant",
                                     "5_prime_UTR_variant", "intron_variant"))

#get total snp from 6 local var
snp<- Reduce(function(x,y) merge(x, y, by = "snp_id", all.x = TRUE, all.y = TRUE),
                     list(a_bali, a_ph, a_mr, a_qr, a_mw, a_qw))

#select private/unique alel
snp$bali<- as.character(snp$bali)
snp$ph<- as.character(snp$ph)
snp$mrm16<- as.character(snp$mrm16)
snp$q100<- as.character(snp$q100)
snp$mr297<- as.character(snp$mr297)
snp$q76<- as.character(snp$q76)
snp[is.na(snp)]<- "nc"
snp$count<- rowSums(snp == "nc")
snp$A<- rowSums(snp == "A")
snp$C<- rowSums(snp == "C")
snp$G<- rowSums(snp == "G")
snp$T<- rowSums(snp == "T")
pv_alel<- filter(snp, count == "5")

#for polymorphic
py_count<- select(snp, snp_id, A, C, G, T)
py_count$countZero<- rowSums(py_count == "0")

uq_bali<- filter(pv_bali, bali != "nc")
uq_ph<- filter(pv_ph, ph != "nc")
uq_mrm16<- filter(pv_mrm16, mrm16 != "nc")
uq_q100<- filter(pv_q100, q100 != "nc")
uq_mr297<- filter(pv_mr297, mr297 != "nc")
uq_q76<- filter(pv_q76, q76 != "nc")

pv_q76<- select(uq_q76, snp_id, q76)#to extract list of pv alleles

#count non coding total snp
nc_tsnp<- sqldf("select * from tsnp where tsnp.snpID NOT IN (select snpID from ann_tsnp)")

#extract unique snp from each variety
snp[is.na(snp)]<- "NC"
snp$countNC<- rowSums(snp == "NC")

ls_snp<- snp %>%
  filter(countNC == 5) %>%
  select(snpID, bali, ph, mrm16, q100, mr297, q76, countNC)

ls_mr297<- ls_snp %>%
  filter(mr297 != "NC") %>%
  select(snpID, mr297)
