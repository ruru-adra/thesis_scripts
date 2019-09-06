#!/bin/bash
for f in *.bam.fxmt.mkdup.addrep.bam;
do
#java -jar /home/cbr14/bioinfo_sware/picard.jar FixMateInformation INPUT=$f OUTPUT=$f.fxmt.bam VALIDATION_STRINGENCY=LENIENT SO=coordinate CREATE_INDEX=TRUE;
#java -Xmx8g -jar /home/cbr14/bioinfo_sware/picard.jar MarkDuplicates INPUT=$f.fxmt.bam OUTPUT=$f.fxmt.mkdup.bam METRICS_FILE=$f.metrics VALIDATION_STRINGENCY=LENIENT CREATE_INDEX=TRUE;
#java -jar /home/cbr14/bioinfo_sware/picard.jar AddOrReplaceReadGroups INPUT=$f.fxmt.mkdup.bam OUTPUT=$f.fxmt.mkdup.addrep.bam RGID=CX145_$f PL=illumina SM=CX145_$f_sample RGLB=CX145_$f_project VALIDATION_STRINGENCY=LENIENT SO=coordinate CREATE_INDEX=TRUE RGPU=none;
#java -jar /home/cbr14/bioinfo_sware/picard.jar BuildBamIndex INPUT=$f.fxmt.mkdup.addrep.bam;
java -jar /home/cbr14/bioinfo_sware/GenomeAnalysisTK.jar -T RealignerTargetCreator -I $f -R /home/cbr14/Desktop/IGV_data/irgsp_genome.fa -o $f.intervals -nt 16 -U ALLOW_N_CIGAR_READS;
java -jar /home/cbr14/bioinfo_sware/GenomeAnalysisTK.jar -T IndelRealigner -R /home/cbr14/Desktop/IGV_data/irgsp_genome.fa -I $f -targetIntervals $f.intervals -o $f.realigned.bam -U ALLOW_N_CIGAR_READS;
#java -jar /home/cbr14/bioinfo_sware/GenomeAnalysisTK.jar -T HaplotypeCaller -R /home/cbr14/Desktop/IGV_data/irgsp_genome.fa -I $f.realigned.bam -o $f.gatk.raw.vcf -nct 32 --genotyping_mode DISCOVERY -stand_call_conf 30 --min_mapping_quality_score 30 -U ALLOW_N_CIGAR_READS;
done
