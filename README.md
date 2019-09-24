# thesis_scripts
**Scripts/source code used for PhD thesis project**

<div id="toc_container">
<p class="toc_title">Contents</p>
<ul class="toc_list">
<li><a href="#First_Point_Header">1 Clean Raw data</>
<li><a href="#Second_Point_Header">2 Mapping reads to reference genomes using bwa</a></li>
<li><a href="#Third_Point_Header">3 SNP calling using GATK</a></li>
<li><a href="#Fourth_Point_Header">4 SNP annotation using SnpEff</a></li>
<li><a href="#Fifth_Point_Header">5 SNP filtering using R</a></li>
<li><a href="#Sixth_Point_Header">6 Total read counts from alignment using htseq-count</a></li>
<li><a href="#Seventh_Point_Header">7 Transcripts assembly using Cufflinks</a></li>
 <li><a href="#Eighth_Point_Header">8 Genes co-expression network analysis</a></li>
</ul>
</div>

<h2 id="First_Point_Header">Clean Raw data</h2>
Raw data of genomes and transcriptomes have been deposited in ENA database (https://www.ebi.ac.uk/ena/browse) under these accessions number: 
<li>PRJEB29070 (Genomes of pigmented rice)</li>
<li>PRJEB32344 (Genomes of non-pigmented rice)</li>
<li>PRJEB34340 (Transcriptomes of pigmented and non-pigmented rice)</li>

<h2 id="Second_Point_Header">Mapping reads to reference genomes using bwa</h2>
Index the reference genome using bwa-index. Oryza japonica cv. Nipponbare was used as a reference genome. You can run this
command:
<pre style="color: silver; background: black;">bwa index nipponbare.fasta

You can run mapping command:
<pre style="color: silver; background: black;">$nohup sh snp_aln.sh




