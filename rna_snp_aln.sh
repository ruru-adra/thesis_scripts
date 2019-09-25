#!/bin/bash
for f in *.bam;
do
java -jar /home/cbr14/bioinfo_sware/picard.jar FixMateInformation INPUT=$f OUTPUT=$f.fxmt.bam VALIDATION_STRINGENCY=LENIENT SO=coordinate CREATE_INDEX=TRUE;
java -jar /home/cbr14/bioinfo_sware/picard.jar MarkDuplicates INPUT=$f.fxmt.bam OUTPUT=$f.fxmt.mkdup.bam METRICS_FILE=$f.metrics VALIDATION_STRINGENCY=LENIENT CREATE_INDEX=TRUE;
java -jar /home/cbr14/bioinfo_sware/picard.jar AddOrReplaceReadGroups INPUT=$f.fxmt.mkdup.bam OUTPUT=$f.fxmt.mkdup.addrep.bam RGID=CX145_$f PL=illumina SM=CX145_$f_sample RGLB=CX145_$f_project VALIDATION_STRINGENCY=LENIENT SO=coordinate CREATE_INDEX=TRUE RGPU=none;
java -jar /home/cbr14/bioinfo_sware/picard.jar BuildBamIndex INPUT=$f.fxmt.mkdup.addrep.bam;
java -jar /home/cbr14/bioinfo_sware/GenomeAnalysisTK.jar -T RealignerTargetCreator -I $f -R /home/cbr14/Desktop/IGV_data/irgsp_genome.fa -o $f.intervals -nt 16 -U ALLOW_N_CIGAR_READS;
java -jar /home/cbr14/bioinfo_sware/GenomeAnalysisTK.jar -T IndelRealigner -R /home/cbr14/Desktop/IGV_data/irgsp_genome.fa -I $f -targetIntervals $f.intervals -o $f.realigned.bam -U ALLOW_N_CIGAR_READS;
java -jar /home/cbr14/bioinfo_sware/GenomeAnalysisTK.jar -T HaplotypeCaller -R /home/cbr14/Desktop/IGV_data/irgsp_genome.fa -I $f.realigned.bam -o $f.gatk.raw.vcf -nct 32 --genotyping_mode DISCOVERY -stand_call_conf 30 --min_mapping_quality_score 30 -U ALLOW_N_CIGAR_READS;
java -jar /home/cmdv/bioinfo_sware/GATK/GenomeAnalysisTK.jar -T SelectVariants -R ../reference/IRGSP-1.0_genome.fasta -V $f.gatk.raw.vcf -selectType SNP -o $f.snp.gatk.raw.vcf;
java -jar /home/cmdv/bioinfo_sware/GATK/GenomeAnalysisTK.jar -T SelectVariants -R ../reference/IRGSP-1.0_genome.fasta -V $f.gatk.raw.vcf -selectType INDEL -o $f.indel.snp.gatk.raw.vcf;
java -jar /home/cmdv/bioinfo_sware/GATK/GenomeAnalysisTK.jar -T VariantFiltration -R ../reference/IRGSP-1.0_genome.fasta -V $f.snp.gatk.raw.vcf -o $f.snp.gatk.hardfilter.vcf --filterExpression "QD < 2.0 ||MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0" --filterName "riceSNP";
java -jar /home/cmdv/bioinfo_sware/GATK/GenomeAnalysisTK.jar -T VariantFiltration -R ../reference/IRGSP-1.0_genome.fasta -V $f.indel.snp.gatk.raw.vcf --filterExpression "QD < 2.0 || FS > 200.0 || ReadPosRankSum < -20.0" --filterName "indel_gatk" -o $f.indel.gatk.hardfilter.vcf;
done
