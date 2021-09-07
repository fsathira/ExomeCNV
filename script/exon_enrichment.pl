#!/usr/bin/perl

print ("wig file: ");
$wig = <STDIN>;
chomp($wig);

print("exon file: ");
$exon= <STDIN>;
chomp($exon);

print ("out file: ");
$out = <STDIN>;
chomp($out);

open(WIG, "$wig"); 
open(EXON, "$exon");
open (OUT, ">$out");

$basecount=0;
$seqcount=0;
$wiglinecount=0;
$all_seqcount=0;
$i=0;
$basecount2=0;
@coverage=(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
$missing_base=0;

$line2 = <EXON>;
$exonlinecount=1;
while ($line1 =<WIG>)
{
        last if ($line2 eq eof);

       	$wiglinecount++;
       	chomp($line1);
       	($w_chrom, $w_pos1, $w_pos2, $w_seqcount) =split(/\s+/, $line1);
	$all_seqcount=$all_seqcount+$w_seqcount;
       	
	chomp ($line2);

       	($e_chrom, $e_pos1, $e_pos2) =split(/\s+/, $line2);

       	if ($w_pos1 >= $e_pos1 && $w_pos2 <= $e_pos2)
	{
		$basecount++;
		$seqcount=$seqcount+$w_seqcount;
		print OUT "-\t-\t$wiglinecount\t$line1\n";
		if($w_seqcount<=100)
                {
                        $coverage[$w_seqcount-1]++;
                }
		else
		{
			$i++;
		}

	}
       	else
	{
		while($w_pos2>$e_pos2)
		{
			print OUT "$exonlinecount\t$line2\t-\t-\t-\n";
			$line2 = <EXON>;
			last if ($line2 eq eof);
			chomp ($line2);
		        ($e_chrom, $e_pos1, $e_pos2) =split(/\s+/, $line2);
			$exonlinecount++;
		}
		print OUT "-\t-\t$wiglinecount\t$line1\n";
		$basecount++;
                $seqcount=$seqcount+$w_seqcount;

                if($w_seqcount<=100)
                {
                        $coverage[$w_seqcount-1]++;
                }
                else
                {
                        $i++;
                }
	}
}
print OUT "$exonlinecount\t$line2\t-\t-\t-\n";
$exonlinecount++;

while($line2=<EXON>)
{
	chomp($line2);
	print OUT "$exonlinecount\t$line2\t-\t-\t-\n";
	$exonlinecount++;
}
print "$e_chrom\t$wiglinecount\t$all_seqcount\t$basecount\t$seqcount\t@coverage\t$i\n";

close(WIG);
close(EXON);
close(OUT);
