##snp annotation
mkdir data/IRGSP_1.0
cat irgsp.gff irgsp.fa > genes.gff
java -jar snpEff.jar build -gff3 -v IRGSP_1.0

java -jar ../../snpEff.jar -v IRGSP_1.0 ../../../../Data/PhD/3000/sra/sra_black/PULUT_BURUNG/output/snp_p_burung.hardfilter.vcf > ann_snp_pburung.vcf 


cut -f 3 transcripts.gff | sort | uniq -c

##check vcf format/debugging
java -jar SnpSift.jar vcfCheck ./data/IRGSP_1.0/amurat_annot.vcf 

##many effects per line
java -jar SnpSift.jar extractFields ./data/IRGSP_1.0/amurat_annot.vcf CHROM POS REF ALT "ANN[*].EFFECT" "ANN[*].GENE" > ./data/IRGSP_1.0/split_per_line2.txt

##one effect per line
cat ann_snp_pburung.vcf | ../../scripts/vcfEffOnePerLine.pl | java -jar ../../SnpSift.jar extractFields - CHROM POS REF ALT "ANN[*].EFFECT" "ANN[*].GENE" > snp_pburung_gene.multiple.line.txt



###download data snpEff
##check the availability of genome database
java -jar snpEff.jar download -v rice_rap201304
