# parameters:
# 	P	file prefix, directory can be specified here as well
#	S 	file suffix, prefix and suffix should form the file name like so $P.$S (notice the dot in between)
# usage:
# 	P=novoalign.CB-1.baseline.snv.targeted.chr
# 	S=exon_parsed.coverage
# 	bash parse_file_by_chr_w_header.sh P S

P=$1
S=$2
F=${P}.${S}
for chr in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X Y
do
  O=${P}.chr${chr}.${S}
  grep chr$chr[[:space:]] $F > $O
done

