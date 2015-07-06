#!/usr/bin/perl

use strict;
use warnings;

my $version = "1.0.0";
my $progname = $0;
$progname =~ s!^.*/!!;

my $num = "";
my $jobfile = "";
my $parn = "";

use Getopt::Long;
GetOptions( 
    "help"=> \my $help,
    "parn=s"=> \$parn,
    "n=s"=> \$num,
    "jobfile=s"=> \$jobfile,
    );

use File::Basename;



if ($help || $num eq "" || $jobfile eq ""){
    print "usage: $progname FILES

version: $version

      options:

        --help           print this message then quit
        --n INT          line to take as command (like this n100)
        --jobfile STRING jobfile from which to read command
        --parn INT       number of parallel jobs (then multiplicated with n)


  --n n100


 created by Stephan Ripke 2012 at MGH, Boston, MA
 in the frame of the PGC
\n";
    exit 2;
}

$num =~ s/n//;
$num = $num * 1;
if ($num == 0) {
    print "--n doesn't make sense: $num after transformation\n";
}


if ($parn ne "") {

    $parn = $parn * 1;
    if ($parn == 0) {
	print "--parn doesn't make sense: $num after transformation\n";
    }

    my $first_n = ($num-1) * $parn;
    $first_n++;
    
    my $last_n = $num * $parn;

    my $lc = 1;

#    my @job_array;
    die "$jobfile: ".$! unless open FILE, "< $jobfile";
    die "$jobfile.sub$num: ".$! unless open OUT, "> $jobfile.sub$num";
    while (my $cmd  = <FILE>){
	chomp ($cmd);

	if ($lc >= $first_n && $lc <= $last_n) {
#	    push @job_array, $cmd;
	    print OUT $cmd." &\n";
	}

	
	$lc++;
    }
    close FILE;
    print OUT "wait\n";
    close OUT;

    system ("chmod u+x $jobfile.sub$num");  

#    exit;
    system ("./$jobfile.sub$num");

    exit;

}




my $sys  = `head -n $num $jobfile | tail -1`;
chomp ($sys);
system ($sys);
#print $sys."\n";




