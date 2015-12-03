#! /usr/bin/perl

######################
#
# impprob_to_2dos 
# 
# Convert impute2's 3 probability output format (i.e.
# Oxford format) to dosages with 2 probabilities. The
# rest of the format is left unchanged.
#
# Since the impute2 format doesn't guarantee that the
# 3 genotype probabilities will sum to 1, we account 
# for the remainder as follows:
# - if the 3 probs sum to < .98, we return "NA" calls
#     (probably poor quality calls)
# - if the 3 probs sum to > 1.1, we return "NA" calls
#     (something's probably gone very wrong)
# - otherwise, divide by sum of probabilities to re-
#     scale (rounded to 3 digits)
#
# Also includes a couple sanity checks:
# - number of fields in input file consistent with
#     3 probability format
# - output file has same number of SNPs (lines) as 
#     input
# 
# Assumes 2 arguments: 
# - input filename (a gzipped impute2 output file)
# - output filename (also gzipped)
#
#
#   written by Raymond Walters
######################

use strict;

use lib $ENV{rp_perlpackages};
use Compress::Zlib;

# verify two arguments
my $num_args = scalar @ARGV;
if ($num_args != 2){
	die "Require exactly 2 arguments (impprob_to_2dos.pl <input_file> <output_file>)\n" ;
}

# get file names
my $input_file = $ARGV[0];
my $output_file = $ARGV[1];
my $output_file_success = $ARGV[1].".fini";

# open I/O streams
my $instream = gzopen("$input_file", "rb")
	or die "Cannot open input file $input_file: $gzerrno\n" ;

my $outstream = gzopen("$output_file", "wb")
	or die "Cannot open output file $output_file: $gzerrno\n" ;

# init line counter
my $n = 0;

### process lines of input file
while ($instream->gzreadline(my $line)){
	$n++;

	# split line on whitespace
	my @cells = split /\s+/, $line;

	# verify number of entries after snp info (5 columns) is a multiple of 3 as expected
	if ( ((scalar @cells - 5) % 3)  != 0){
		die "Incorrect number of fields in line $n \n";
	}

	# grab snp info in first 5 columns to init output
	my $outline = join(' ', @cells[0..4]);

	# loop sets of 3 probabilities
	for (my $i=5; $i < $#cells; $i += 3){
		# init
		my $probs;
		
		# check sum valid, then use to rescale
		# print format: 3 digits, except shorten 1.000(=1) or 0.000(=0)
		# - Important: leading space required for output formatting
		my $probsum = @cells[$i] + @cells[$i+1] + @cells[$i+2];
		if($probsum > 1.1 or $probsum < .98){
			$probs = " NA NA";
		}else{
			$probs = sprintf(" %1.3f %1.3f", @cells[$i]/$probsum, @cells[$i+1]/$probsum);
			$probs =~ s/\.000//g;
		}

		# record (append to output)
		$outline .= $probs;
	}

	# output line of results
	$outstream->gzwrite($outline . "\n");
}

# verify hit end of file
if ($gzerrno != Z_STREAM_END){
	die "Error reading from file $input_file: $gzerrno" . ($gzerrno+0) . "\n" ;
}

$instream->gzclose();
$outstream->gzclose();

# sanity check: make sure same number of lines (SNPs) in input, output
my $nsnp_in = `zcat $input_file | wc -l` ;
my $nsnp_out = `zcat $output_file | wc -l` ;

if( $nsnp_out != $nsnp_in ){
	die "Number of output SNPs ($nsnp_out) doesn't match number in input file ($nsnp_in) \n";
}

system ("touch $output_file_success");

# exit successfully 
exit 0;
