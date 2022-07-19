#!/home/ingy/perl5/perlbrew/perls/perl-5.28.0/bin/perl

use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/../lib";

use YAMLScript::Compiler;
use YAMLScript::Runtime;

use XXX;

my $file = shift;

my $compiler = YAMLScript::Compiler->new(
    file => $file,
);
my $code = $compiler->compile;

push @{$code->NEED}, 'YS-TestYAMLScript';

my $runtime = YAMLScript::Runtime->new(
    code => $code,
    argv => [@ARGV],
);

$runtime->run;