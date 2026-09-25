#!/usr/bin/env perl
#------------------------------------------------------------------------------
# File:         eperl.pl
#
# Description:  Stub for building a generic packed-perl binary with PAR::Packer.
#               The resulting binary contains the perl interpreter plus the
#               CPAN dependencies from pp_build_exe.args, but no application
#               script. At run time it executes an external Perl script using
#               the packed dependencies.
#
# Usage:
#               eperl <script> [args...]
#
# Example:
#               ./eperl exiftool -ver
#------------------------------------------------------------------------------
use strict;
use warnings;

my $script = shift @ARGV;
unless (defined $script) {
    die "Usage: $0 <script> [args...]\n";
}

# `do` looks relative paths up in @INC ('.' is no longer in @INC on modern
# perl), so anchor them to the current directory.
$script = "./$script" if $script !~ m{^(?:[./\\]|[A-Za-z]:)};

# Make the target script see the $0 / PAR_0 it expects. Scripts that derive
# their library directory from $0 need this to find their libs next to
# themselves rather than next to the packed binary.
$0 = $script;
$ENV{PAR_0} = $script;

my $ret = do $script;
if ($@) {
    die "Couldn't parse $script: $@\n";
}
unless (defined $ret) {
    die "Couldn't do $script: $!\n" if $!;
    die "Couldn't run $script\n";
}
