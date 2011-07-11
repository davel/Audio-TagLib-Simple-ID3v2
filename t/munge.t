#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use FindBin;
use File::Temp qw/ tempdir /;
use MP3::Tag;

use Audio::TagLib::Simple::ID3v2;

my $tempdir = tempdir( CLEANUP => 1 );

is(system("cp", "--", "$FindBin::Bin/tone.mp3", "$tempdir/a.mp3"), 0);

my $o = Audio::TagLib::Simple::ID3v2->new( "$tempdir/a.mp3" );
isa_ok($o, 'Audio::TagLib::Simple::ID3v2Ptr');
$o->strip_all_tags();
$o->add_tag("TIT2", "hello world!");
$o->write();

undef $o;

my $m = MP3::Tag->new("$tempdir/a.mp3");
is($m->title, "hello world!");

done_testing();
