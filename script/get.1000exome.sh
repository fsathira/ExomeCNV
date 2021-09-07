subj=$1
mkdir $subj
cd $subj
wget ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/data/$subj/alignment/*.exon_targetted.*.bam

