#!/bin/bash
bwa mem -M -t 8 /reference/nipponbare.fa /reads/bali_1.fq.gz /reads/bali_2.fq.gz > out_bali.sam
bwa mem -M -t 8 /reference/nipponbare.fa /reads/ph9_1.fq.gz /reads/ph9_2.fq.gz > out_ph9.sam
bwa mem -M -t 8 /reference/nipponbare.fa /reads/mrm16_1.fq.gz /reads/mrm16_2.fq.gz > out_mrm16.sam
bwa mem -M -t 8 /reference/nipponbare.fa /reads/q100_1.fq.gz /reads/q100_2.fq.gz > out_q100.sam
bwa mem -M -t 8 /reference/nipponbare.fa /reads/mr297_1.fq.gz /reads/mr297_2.fq.gz > out_mr297.sam
bwa mem -M -t 8 /reference/nipponbare.fa /reads/q76_1.fq.gz /reads/q76_2.fq.gz > out_q76.sam
