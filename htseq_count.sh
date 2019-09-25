#!bin/bash
htseq-count -s yes -r pos -t gene -i Name -f bam aln_bali.bam nipponbare.gff > bali_counts.out
htseq-count -s yes -r pos -t gene -i Name -f bam aln_ph9.bam nipponbare.gff > ph9_counts.out
htseq-count -s yes -r pos -t gene -i Name -f bam aln_mrm16.bam nipponbare.gff > mrm16_counts.out
htseq-count -s yes -r pos -t gene -i Name -f bam aln_q100.bam nipponbare.gff > q100_counts.out
htseq-count -s yes -r pos -t gene -i Name -f bam aln_mr297.bam nipponbare.gff > mr297_counts.out
htseq-count -s yes -r pos -t gene -i Name -f bam aln_q76.bam nipponbare.gff > q76_counts.out
