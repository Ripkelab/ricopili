package Ricopili::Utils;

use strict;
use warnings;

BEGIN {
    require Exporter;
    our @ISA         = qw(Exporter);
    our @EXPORT_OK   = qw(trans $conf_file);
}

#############################
# read config file
#############################


our $conf_file;

if (-e  $ENV{RPHOME}."/ricopili.conf") {
    $conf_file = $ENV{RPHOME}."/ricopili.conf";
}
elsif (-e  $ENV{HOME}."/ricopili.conf") {
    $conf_file = $ENV{HOME}."/ricopili.conf";
}
else {
    print "Error: ricopili.conf file not found\n";
    print "       neither in env HOME\n";
    print "           nor in env RPHOME\n";
    die;
}

print "Config_file: $conf_file\n";
#print "sleep\n";
#sleep(10);

my %conf = ();

die $!."($conf_file)" unless open FILE, "< $conf_file";
while (my $line = <FILE>){
    next if ($line =~ /^#/);
    my @cells = split /\s+/, $line;
    next unless ($#cells >= 1);

    # expand '~' for home directory in conf entries
    $cells[1] =~ s/^~/$ENV{HOME}/;

    # expand environment variables defined in the current environment, 
    # leave currently undefined env vars as they were:


    my $tmp_env = $cells[1];
    if ($tmp_env =~ /^ENV\{/){
	$tmp_env =~ s/^ENV\{//;
	$tmp_env =~ s/\}$//;
	if (defined $ENV{$tmp_env}) {
	    $cells[1]=$ENV{$tmp_env};
	    print "replacing $tmp_env with $cells[1] in $conf_file\n";
	}
	else {
	    print "environment variable $tmp_env in $conf_file is not defined\n";
	}
    }
    
#    print "using $cells[1] from $conf_file\n";


    # the following got into problems with some cluster environments
#    $cells[1] =~ s/\$\{(\w+)\}/defined $ENV{$1} ? "$ENV{$1}" : "\$\{$1\}"/eg;
#    $cells[1] =~ s/\$(\w+)/defined $ENV{$1} ? "$ENV{$1}" : "\$$1"/eg;

    

    $conf{$cells[0]} = $cells[1];
}
close FILE;

sub trans {
    my ($expr) = @_;
    unless (exists $conf{$expr}) {
	die "config file without entry: $expr\n";
    }
    $conf{$expr};
}


1;
