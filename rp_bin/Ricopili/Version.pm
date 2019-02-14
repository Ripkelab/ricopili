package Ricopili::Version;

use strict;
use warnings;


######################################
### versioning
##################################
use Exporter;
our @ISA = 'Exporter';
#our @EXPORT = qw($rp_version $rp_logo, $rp_header);
our @EXPORT = qw($rp_header $rp_version);

our ($rp_header, $rp_version);



$rp_version = "2019_Feb_18.001" ;


my $rp_logo = <<'END_TXT';

       _                 _ _ _ 
  _ __(_) ___ ___  _ __ (_) (_)
 | '__| |/ __/ _ \| '_ \| | | |
 | |  | | (_| (_) | |_) | | | |
 |_|  |_|\___\___/| .__/|_|_|_|
                  |_|          

END_TXT

$rp_header = $rp_logo;
$rp_header .= "#######################################################################\n";
$rp_header .= "#######################################################################\n";
$rp_header .= "##                                                                  ###\n";
$rp_header .= "##   MODULE - module of ricopili pipeline                    ###\n";
$rp_header .= "##                      version: $rp_version                     ###\n";
$rp_header .= "##                                                                  ###\n";
$rp_header .= '## https://sites.google.com/a/broadinstitute.org/ricopili/home      ###'."\n";
$rp_header .= '## Stephan Ripke: sripke@broadinstitute.org                         ###'."\n";
$rp_header .= "##                                                                  ###\n";
$rp_header .= "#######################################################################\n";
$rp_header .= "#######################################################################\n\n";
