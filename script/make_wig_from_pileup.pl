#!/usr/bin/perl
print ("pileup file: ");
$pileup = <STDIN>;
chomp($pileup);

print ("wig file: ");
$wig = <STDIN>;
chomp($wig);

open(PILEUP, "$pileup");
open (WIG, ">$wig");

$p_length=0;
$w_length=0;
$cov=0;

#print WIG "track type=wiggle_0 name=\"Coverage\" description=\"Solexa Sequence Coverage per Base Position\" group=\"user\" visibility=\"full\" autoScale=\"on\" priority=20 color=0,0,0\n";

$line=<PILEUP>;
chomp($line);
# ($w_chrom, $w_pos, $ref, $seq, $qual, $SNP_q, $map_q, $w_seqcount,$read_base,$read_q) =split(/\s+/, $line);
($w_chrom, $w_pos, $seq, $w_seqcount,$read_base,$read_q) =split(/\s+/, $line);
$prv_pos = $w_pos;
$pos1=$w_pos-1;
print WIG ("$w_chrom\t$pos1\t$w_pos\t$w_seqcount\n");
$p_length++;
$w_length++;
$cov = $cov + $w_seqcount;

while($line=<PILEUP>)
{
	chomp($line);
#	($w_chrom, $w_pos, $ref, $seq, $qual, $SNP_q, $map_q, $w_seqcount,$read_base,$read_q) =split(/\s+/, $line);
	($w_chrom, $w_pos, $seq, $w_seqcount,$read_base,$read_q) =split(/\s+/, $line);
	$pos1=$w_pos-1;

	if($w_pos eq $prv_pos)
	{
		$p_length++;
	}

	else
	{
		print WIG "$w_chrom\t$pos1\t$w_pos\t$w_seqcount\n";
		$p_length++;
		$w_length++;
		$cov = $cov + $w_seqcount;
	}
	$prv_pos=$w_pos;
}

print "$p_length\t$w_length\t$cov\n";
