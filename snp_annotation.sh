#!/bin/bash

###download data snpEff
java -jar snpEff.jar download -v rice_rap201304

#create rice gene annotation as references
cat irgsp.gff irgsp.fa > genes.gff
java -jar snpEff.jar build -gff3 -v IRGSP_1.0

#annotate snp
java -jar snpEff.jar -v IRGSP_1.0 *snp.vcf > ann_snp*.vcf 


##annotate many effects per line
java -jar SnpSift.jar extractFields ./data/IRGSP_1.0/amurat_annot.vcf CHROM POS REF ALT "ANN[*].EFFECT" "ANN[*].GENE" > ./data/IRGSP_1.0/split_per_line2.txt

##one effect per line
cat ann_snp_pburung.vcf | ../../scripts/vcfEffOnePerLine.pl | java -jar ../../SnpSift.jar extractFields - CHROM POS REF ALT "ANN[*].EFFECT" "ANN[*].GENE" > snp_pburung_gene.multiple.line.txt


