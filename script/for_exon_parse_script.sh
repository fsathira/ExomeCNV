# $1 is the wig file prefix
# $2 is the exome definition bed file

P=exon_enrichment.pl
W=$1
G=$2
O=$W

for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X Y; do echo "perl $P <<END"; echo "$W.chr$i.wig"; echo "${G}_chr${i}"; echo "$O.chr$i.exon_parsed.wig"; echo "END"; done;

