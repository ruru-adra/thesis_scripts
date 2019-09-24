#!/bin/bash
##download rice gene annotation
java -jar snpEff.jar download -v rice_rap201304

#create rice gene annotation as references
cat irgsp.gff irgsp.fa > genes.gff
java -jar snpEff.jar build -gff3 -v IRGSP_1.0

#annotate snp
java -jar snpEff.jar -v IRGSP_1.0 bali_snp.vcf > ann_bali_snp.vcf
java -jar snpEff.jar -v IRGSP_1.0 ph9_snp.vcf > ann_ph9_snp.vcf
java -jar snpEff.jar -v IRGSP_1.0 mrm16_snp.vcf > ann_mrm16_snp.vcf
java -jar snpEff.jar -v IRGSP_1.0 q100_snp.vcf > ann_q100_snp.vcf
java -jar snpEff.jar -v IRGSP_1.0 mr297_snp.vcf > ann_mr297_snp.vcf
java -jar snpEff.jar -v IRGSP_1.0 q76_snp.vcf > ann_q76_snp.vcf

##annotate many effects per line
java -jar SnpSift.jar extractFields ann_bali_snp.vcf CHROM POS REF ALT "ANN[*].EFFECT" "ANN[*].GENE" 
> ann_bali_snp_all_per_line.txt
java -jar SnpSift.jar extractFields ann_ph9_snp.vcf CHROM POS REF ALT "ANN[*].EFFECT" "ANN[*].GENE" 
> ann_ph9_snp_all_per_line.txt
java -jar SnpSift.jar extractFields ann_mrm16_snp.vcf CHROM POS REF ALT "ANN[*].EFFECT" "ANN[*].GENE" 
> ann_mrm16_snp_all_per_line.txt
java -jar SnpSift.jar extractFields ann_q100_snp.vcf CHROM POS REF ALT "ANN[*].EFFECT" "ANN[*].GENE" 
> ann_q100_snp_all_per_line.txt
java -jar SnpSift.jar extractFields ann_mr297_snp.vcf CHROM POS REF ALT "ANN[*].EFFECT" "ANN[*].GENE" 
> ann_mr297_snp_all_per_line.txt
java -jar SnpSift.jar extractFields ann_q76_snp.vcf CHROM POS REF ALT "ANN[*].EFFECT" "ANN[*].GENE" 
> ann_q76_snp_all_per_line.txt

##one effect per line
cat ann_bali_snp.vcf | ../../scripts/vcfEffOnePerLine.pl | java -jar SnpSift.jar extractFields - CHROM POS REF ALT 
"ANN[*].EFFECT" "ANN[*].GENE" > ann_bali_snp_per_line.txt
cat ann_ph9_snp.vcf | ../../scripts/vcfEffOnePerLine.pl | java -jar SnpSift.jar extractFields - CHROM POS REF ALT 
"ANN[*].EFFECT" "ANN[*].GENE" > ann_ph9_snp_per_line.txt
cat ann_mrm16_snp.vcf | ../../scripts/vcfEffOnePerLine.pl | java -jar SnpSift.jar extractFields - CHROM POS REF ALT 
"ANN[*].EFFECT" "ANN[*].GENE" > ann_mrm16_snp_per_line.txt
cat ann_q100_snp.vcf | ../../scripts/vcfEffOnePerLine.pl | java -jar SnpSift.jar extractFields - CHROM POS REF ALT 
"ANN[*].EFFECT" "ANN[*].GENE" > ann_q100_snp_per_line.txt
cat ann_mr297_snp.vcf | ../../scripts/vcfEffOnePerLine.pl | java -jar SnpSift.jar extractFields - CHROM POS REF ALT 
"ANN[*].EFFECT" "ANN[*].GENE" > ann_mr297_snp_per_line.txt
cat ann_q76_snp.vcf | ../../scripts/vcfEffOnePerLine.pl | java -jar SnpSift.jar extractFields - CHROM POS REF ALT 
"ANN[*].EFFECT" "ANN[*].GENE" > ann_q76_snp_per_line.txt


