source("/home/fah/exome_cnv/basic.util.R")
source("/home/fah/exome_cnv/cnv.analyze.R")
source("/home/fah/exome_cnv/eCNV.analyze.R")
source("/home/fah/exome_cnv/power/roc.R")

setwd("/home/fah/exome_cnv/demo")

chr.list="chr"%+%c("1","2","5","6","7","8","9","10","11","12","13","15","17","19","X","Y")

suffix = ".exon_parsed.coverage"

prefix = "/scratch0/tmp/hlee/Val_100805_HWUSI-EAS335_628A9/output/TACT/SNV/WIG/exon_parsed/coverage/100805_HWUSI-EAS335_628A9.lane3.TACT.novoalign.sorted.rmdup.SNV.sorted.targeted."
vilain1 = read.all.coverage(prefix, suffix, chr.list, header=F)

prefix = "/scratch0/tmp/hlee/Val_100805_HWUSI-EAS335_628A9/output/ATTT/SNV/WIG/exon_parsed/coverage/100805_HWUSI-EAS335_628A9.lane3.ATTT.novoalign.sorted.rmdup.SNV.sorted.targeted."
vilain2 = read.all.coverage(prefix, suffix, chr.list, header=F)

exome = read.delim("/data/storage-1-02/hlee/Vilain_05212010/2010_5_BaitsSureSelect_notOverlapping.txt", header=F)
colnames(exome) = c("chr", "probe_start", "probe_end")

# mkdir logR in your cwd
vilain12.logR = calculate.logR(vilain1, vilain2)
save.logR(vilain12.logR, exome, "vilain12")

# do.eCNV.R (use qsub)

suffix = ".RData"
prefix = "/home/fah/exome_cnv/demo/vilain12.eCNV.9999.5.spec.c0/vilain12.eCNV.9999.5.spec.c0."
vilain12.eCNV = read.eCNV(prefix, suffix)
plot.eCNV(vilain12.eCNV, lim.quantile=0.99, style="idx", line.plot=F)
vilain12.cnv = multi.CNV.analyze(vilain1, vilain2, list(vilain12.eCNV), coverage.cutoff=5, min.spec=0.99, min.sens=0.99, option="auc", c=0)
plot.eCNV(vilain12.cnv, lim.quantile=0.99, style="bp", bg.cnv=vilain12.eCNV, line.plot=T)
write.output(vilain12.eCNV, vilain12.cnv, "vilain12")

