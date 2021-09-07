fullpath=$1
filename=$(basename $fullpath)
des=$2

bash make_wig_from_pileup.sh $fullpath > $des/$filename.pileup2wig.sh
bash $des/$filename.pileup2wig.sh

bash parse_file_by_chr_wo_header.sh $des/$filename wig

bash for_exon_parse_script.sh $des/$filename > $des/$filename.parse.sh
bash $des/$filename.parse.sh

bash coverage.sh $des/$filename > $des/$filename.cover.sh
bash $des/$filename.cover.sh

