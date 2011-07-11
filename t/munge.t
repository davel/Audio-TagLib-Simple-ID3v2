#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use FindBin;

use Audio::TagLib::Simple::ID3v2;

my $o = Audio::TagLib::Simple::ID3v2->new( "$FindBin::Bin/tone.mp3" );
isa_ok($o, 'Audio::TagLib::Simple::ID3v2Ptr');
$o->strip_all_tags();

my $str = "bar";
# utf8::upgrade($str);

$o->add_tag("foo", $str);

done_testing();
