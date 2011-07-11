#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use FindBin;

use Audio::TagLib::ID3v2;

my $o = Audio::TagLib::ID3v2->new( filename => "$FindBin::Bin/tone.mp3" );
isa_ok($o, 'Audio::TagLib::ID3v2');
ok $o->{data};
diag $o->{data};

done_testing();
