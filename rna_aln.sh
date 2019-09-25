#!/bin/bash
tophat2 -p 4 -G nipponbare.gff3 -o aln_bali.bam rna_bali_1.fastq rna_bali_2.fastq
tophat2 -p 4 -G nipponbare.gff3 -o aln_ph9.bam rna_ph9_1.fastq rna_ph9_2.fastq
tophat2 -p 4 -G nipponbare.gff3 -o aln_mrm16.bam rna_mrm16_1.fastq rna_mrm16_2.fastq
tophat2 -p 4 -G nipponbare.gff3 -o aln_q100.bam rna_q100_1.fastq rna_q100_2.fastq
tophat2 -p 4 -G nipponbare.gff3 -o aln_mr297.bam rna_mr297_1.fastq rna_mr2972.fastq
tophat2 -p 4 -G nipponbare.gff3 -o aln_q76.bam rna_q76_1.fastq rna_q76_2.fastq
