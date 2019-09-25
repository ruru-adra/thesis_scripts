#!/bin/bash
for f in *.sam;
do
java -jar /home/cmdv/bioinfo_sware/picard-tools-1.141/picard.jar SortSam INPUT=$f OUTPUT=$f.bam VALIDATION_STRINGENCY=LENIENT CREATE_INDEX=TRUE SO=coordinate;
java -jar /home/cmdv/bioinfo_sware/picard-tools-1.141/picard.jar BamIndexStats I=$f.bam > $f.bam.stats;
java -jar /home/cmdv/bioinfo_sware/picard-tools-1.141/picard.jar FixMateInformation INPUT=$f.bam OUTPUT=$f.fxmt.bam VALIDATION_STRINGENCY=LENIENT SO=coordinate CREATE_INDEX=TRUE;
java -jar /home/cmdv/bioinfo_sware/picard-tools-1.141/picard.jar MarkDuplicates INPUT=$f.fxmt.bam OUTPUT=$f.fxmt.mkdup.bam METRICS_FILE=$f.metrics VALIDATION_STRINGENCY=LENIENT CREATE_INDEX=TRUE;
java -jar /home/cmdv/bioinfo_sware/picard-tools-1.141/picard.jar AddOrReplaceReadGroups INPUT=$f.fxmt.mkdup.bam OUTPUT=$f.fxmt.mkdup.addrep.bam RGID=CX145_$f PL=illumina SM=CX145_$f_sample RGLB=CX145_$f_project VALIDATION_STRINGENCY=LENIENT SO=coordinate CREATE_INDEX=TRUE RGPU=none;
java -jar /home/cmdv/bioinfo_sware/picard-tools-1.141/picard.jar BuildBamIndex INPUT=$f.fxmt.mkdup.addrep.bam;
java -jar /home/cmdv/bioinfo_sware/GATK/GenomeAnalysisTK.jar -T RealignerTargetCreator -I $f.fxmt.mkdup.addrep.bam -R ../../genome/IRGSP-1.0_genome.fasta -o $f.intervals -nt 16;
java -jar /home/cmdv/bioinfo_sware/GATK/GenomeAnalysisTK.jar -T IndelRealigner -R ../../genome/IRGSP-1.0_genome.fasta -I $f.fxmt.mkdup.addrep.bam -targetIntervals $f.intervals -o $f.realn.bam;
java -jar /home/cmdv/bioinfo_sware/GATK/GenomeAnalysisTK.jar -T HaplotypeCaller -R ../reference/IRGSP-1.0_genome.fasta -I $f.merged.bam -o $f.gatk.raw.vcf -nct 32 --genotyping_mode DISCOVERY -stand_call_conf 30 -stand_emit_conf 10;
java -jar /home/cmdv/bioinfo_sware/GATK/GenomeAnalysisTK.jar -T SelectVariants -R ../reference/IRGSP-1.0_genome.fasta -V $f.gatk.raw.vcf -selectType SNP -o $f.snp.gatk.raw.vcf;
java -jar /home/cmdv/bioinfo_sware/GATK/GenomeAnalysisTK.jar -T SelectVariants -R ../reference/IRGSP-1.0_genome.fasta -V $f.gatk.raw.vcf -selectType INDEL -o $f.indel.snp.gatk.raw.vcf;
java -jar /home/cmdv/bioinfo_sware/GATK/GenomeAnalysisTK.jar -T VariantFiltration -R ../reference/IRGSP-1.0_genome.fasta -V $f.snp.gatk.raw.vcf -o $f.snp.gatk.hardfilter.vcf --filterExpression "QD < 2.0 ||MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0" --filterName "riceSNP";
java -jar /home/cmdv/bioinfo_sware/GATK/GenomeAnalysisTK.jar -T VariantFiltration -R ../reference/IRGSP-1.0_genome.fasta -V $f.indel.snp.gatk.raw.vcf --filterExpression "QD < 2.0 || FS > 200.0 || ReadPosRankSum < -20.0" --filterName "indel_gatk" -o $f.indel.gatk.hardfilter.vcf;
done
