#!/usr/bin/perl

print("extend bp: ");
$bp = <STDIN>;
chomp($bp);

print("exon file: ");
$exon= <STDIN>;
chomp($exon);

print ("out file: ");
$out = <STDIN>;
chomp($out);

open(EXON, "$exon");
open (OUT, ">$out");

$line1=<EXON>;
chomp($line1);
($e_chrom, $e_pos1, $e_pos2) =split(/\s+/, $line1);
$previous_ch=$e_chrom;
$previous_start=$e_pos1-$bp;
$previous_end=$e_pos2+$bp;

$i=$previous_end-$previous_start+1;
for($x=0;$x<$i;$x++)
{
	$pos=$previous_start+$x;
	print OUT ("$e_chrom\t$pos\n");        
}

while ($line1 =<EXON>)
{
       	chomp($line1);
       	($e_chrom, $e_pos1, $e_pos2) =split(/\s+/, $line1);
	$e_pos1=$e_pos1-$bp;
	$e_pos2=$e_pos2+$bp;       	

	if ($e_chrom eq $previous_ch && $e_pos1 <$previous_end)
	{
		$i=$e_pos2-$previous_end+1;
		for($x=1;$x<$i;$x++)
		{
			$pos=$previous_end+$x;
			print OUT ("$e_chrom\t$pos\n");
		}
	}

	else
        {
                $i=$e_pos2-$e_pos1+1;
                for($x=0;$x<$i;$x++)
                {
			$pos=$e_pos1+$x;
                        print OUT ("$e_chrom\t$pos\n");
                }
        }
	$previous_ch=$e_chrom;
	$previous_start=$e_pos1;
	$previous_end=$e_pos2;	
}
close(EXON);
close(OUT);
