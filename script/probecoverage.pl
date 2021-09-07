#!/usr/bin/perl

print ("enriched wig file: ");
$wig = <STDIN>;
chomp($wig);

print("extend bp: ");
$bp = <STDIN>;
chomp($bp);

print("cutoff: ");
$cut = <STDIN>;
chomp($cut);

print ("out file: ");
$out = <STDIN>;
chomp($out);

open(WIG, "$wig");

@master = ();
$filelength=0;
while(<WIG>)
{
        $line = $_;
        chomp($line);
        @new_row = split(/\s+/, $line);
        push(@master, [ @new_row ]);
        $filelength++;
}
print("The wig file has $filelength lines\n");

open ($OUT, "+>$out");
print $OUT("probe\tchr\tprobe_start\tprobe_end\ttargeted base\tsequenced base\tcoverage\taverage coverage\tbase with >10 coverage\n");

if($master[0][0] eq 1)
{
	$target = $master[0][3]-$master[0][2]+1+$bp*2;
        print $OUT("probe1\t$master[0][1]\t$master[0][2]\t$master[0][3]\t$target\t0\t0\t0\t0\n");
	$i=1;
}

else
{
	$i=0;
}

$j=0;
@coverage=();
while($i<$filelength)
{
	if($master[$i][6] eq "-")
	{
		if($master[$i][0]-1 eq $master[$i-1][0])
		{
			$target = $master[$i][3]-$master[$i][2]+1+$bp*2;
			print $OUT("probe$master[$i][0]\t$master[$i][1]\t$master[$i][2]\t$master[$i][3]\t$target\t0\t0\t0\t0\n");
			$i++;
		}
		
		else
		{
			$target = $master[$i][3]-$master[$i][2]+1+$bp*2;
			$sum=$master[$i-1][6];
			if($master[$i-1][6]>=$cut){$ten=1;}
			else{$ten=0;}
			for($k=1; $k<$j; $k++)
			{
				$sum=$sum+$master[$i-$k-1][6]; 
				if($master[$i-$k-1][6]>=$cut)
				{$ten++;}
			}
			$average=$sum/$target;
			print $OUT("probe$master[$i][0]\t$master[$i][1]\t$master[$i][2]\t$master[$i][3]\t$target\t$j\t$sum\t$average\t$ten\n");
	                $i++;
			$j=0;
		}
	}
	
	else
	{
		$j++;
		$i++;
	}
}
close($OUT);
