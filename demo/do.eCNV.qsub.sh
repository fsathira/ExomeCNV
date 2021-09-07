for chr in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X Y
do
  qsub -N eCNV.chr$chr -S /bin/bash -cwd -pe serial 1 -e output/eCNV.chr$chr.err -o output/eCNV.chr$chr.out do.eCNV.sh chr$chr
done

