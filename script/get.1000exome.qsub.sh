for subj in NA06986 NA07346 NA11829 NA11831 NA11919 NA11920 NA11992 NA11994 NA12003 NA12045 NA12155 NA12748 NA12829 NA12830 NA12878 NA12889 NA12890 NA12891 NA12892 NA18486 NA18489 NA18499 NA18501 NA18504 NA18516 NA18519 NA18520 NA18522 NA18853 NA18856 NA18870 NA18871 NA18959 NA18960 NA18961 NA19065 NA19102 NA19116 NA19172 NA19238
do
  qsub -N get.1000exome.$subj -S /bin/bash -cwd -pe serial 1 -e output/$subj.err -o output/$subj.out get.1000exome.sh $subj
done

# NA11832 NA07051 is done manually