N=$1
F=/scratch0/tmp/fah/hg19/hg19.fa
D=/scratch0/tmp/fah/1000genome/$N
O=$N

#mkdir $D/output

#samtools merge $D/output/$O.bam $D/*.ILLUMINA.*.bam

/share/apps/samtools-current/samtools sort -m 20000000000  $D/$O.chrom1.ILLUMINA.*.bam $D/output/$O.sorted

#/usr/java/latest/bin/java -jar /share/apps/picard-tools-1.13/MarkDuplicates.jar I=$D/output/$O.sorted.bam O=$D/output/$O.sorted.rmdup.bam REMOVE_DUPLICATES=TRUE VALIDATION_STRINGENCY=SILENT MAX_RECORDS_IN_RAM=4000000 TMP_DIR=$D/tmpfiles METRICS_FILE=$D/output/$O.sorted.rmdup.metrics ASSUME_SORTED=TRUE

/share/apps/samtools-current/samtools pileup -c -f $F -r 0.0000007 -l /home/fah/tmp/P3_consensus_exonic_targets/P3_consensus_exonic_targets_for_pileup $D/output/$O.sorted.bam > $D/output/$O.pileup

bash /home/fah/tmp/make_wig_from_pileup.sh $D/output/$O > $D/output/$O.pileup2wig.sh
bash $D/output/$O.pileup2wig.sh

python /home/fah/tmp/putChr.py $D/output/$O.wig $D/output/tmp
mv $D/output/tmp $D/output/$O.wig

#bash /home/fah/tmp/parse_file_by_chr_wo_header.sh $D/output/$O wig

bash /home/fah/exome_cnv/1000genome/for_exon_parse_script.sh $D/output/$O > $D/output/$O.parse.sh
bash $D/output/$O.parse.sh

bash /home/fah/exome_cnv/1000genome/coverage.sh $D/output/$O > $D/output/$O.cover.sh
bash $D/output/$O.cover.sh

