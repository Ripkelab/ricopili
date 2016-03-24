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

our $conf_file = $ENV{HOME}."/ricopili.conf";
my %conf = ();

die $!."($conf_file)" unless open FILE, "< $conf_file";
while (my $line = <FILE>){
    next if ($line =~ /^#/);
    my @cells = split /\s+/, $line;
    next unless ($#cells >= 1);

    # expand environment variables and '~' for home directory in conf entries
    $cells[1] =~ s/^~/$ENV{HOME}/;
    $cells[1] =~ s/\$\{(\w+)\}/$ENV{$1}/g;
    $cells[1] =~ s/\$(\w+)/$ENV{$1}/g;

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
