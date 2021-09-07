P=/home/fah/tmp/probecoverage.pl
I=$1

for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X Y; do echo "perl $P <<END"; echo "$I.chr$i.exon_parsed.wig"; echo "0"; echo "10"; echo "$I.chr$i.exon_parsed.coverage"; echo "END"; done;
