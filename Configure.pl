# Copyright (C) 2009, Parrot Foundation.
# $Id$

use strict;
use warnings;
use 5.008;

my $build_dir = '../..';
my $hll       = 'lolcode';
my $cmd       = qq{$^X -Ilib tools/dev/reconfigure.pl --step=gen::languages --languages=$hll};

print "Running '$cmd' in $build_dir\n";
chdir $build_dir;
`$cmd`

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:

