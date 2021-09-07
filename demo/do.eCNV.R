source("/home/fah/exome_cnv/eCNV.analyze.R")

chr = commandArgs(T)

normal.prefix = "/scratch0/tmp/hlee/Val_100805_HWUSI-EAS335_628A9/output/TACT/SNV/WIG/exon_parsed/coverage/100805_HWUSI-EAS335_628A9.lane3.TACT.novoalign.sorted.rmdup.SNV.sorted.targeted."
tumor.prefix = "/scratch0/tmp/hlee/Val_100805_HWUSI-EAS335_628A9/output/ATTT/SNV/WIG/exon_parsed/coverage/100805_HWUSI-EAS335_628A9.lane3.ATTT.novoalign.sorted.rmdup.SNV.sorted.targeted."
suffix = ".exon_parsed.coverage"

normal = read.table(normal.prefix %+% chr %+% suffix, header=F, sep='\t')
colnames(normal) = COVERAGE_HEADER
tumor = read.table(tumor.prefix %+% chr %+% suffix, header=F, sep='\t')
colnames(tumor) = COVERAGE_HEADER

load("logR/vilain12.logR." %+% chr %+% ".RData")

ecnv = classify.eCNV(normal, tumor, logR, min.spec=0.9999, min.sens=0.5, option="spec", c=0, l=70)
save(ecnv, file="vilain12.eCNV.9999.5.spec.c0." %+% chr %+% ".RData")

