#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use FindBin;
use File::Temp qw/ tempdir /;
use MP3::Tag;

use Audio::TagLib::Simple::ID3v2;

my $tempdir = tempdir( CLEANUP => 1 );

{
    is(system("cp", "--", "$FindBin::Bin/tone.mp3", "$tempdir/a.mp3"), 0);
    my $o = Audio::TagLib::Simple::ID3v2->new( "$tempdir/a.mp3" );
    isa_ok($o, 'Audio::TagLib::Simple::ID3v2Ptr');
    $o->strip_all_tags();
    $o->add_tag("TIT2", "hello world\x{2603}!");
    $o->write();

    undef $o;

    my $m = MP3::Tag->new("$tempdir/a.mp3");
    is($m->title, "hello world\x{2603}!");
}
{
    my $type = "TIT2";
    my $value = "hello world\xff";

    utf8::downgrade($type);
    utf8::downgrade($value);

    ok !utf8::is_utf8($type);
    ok !utf8::is_utf8($value);

    is(system("cp", "--", "$FindBin::Bin/tone.mp3", "$tempdir/a.mp3"), 0);
    my $a = Audio::TagLib::Simple::ID3v2->new( "$tempdir/a.mp3" );
    $a->add_tag($type, $value);
    $a->write();

    utf8::upgrade($type);
    utf8::upgrade($value);

    ok utf8::is_utf8($type);
    ok utf8::is_utf8($value);

    is(system("cp", "--", "$FindBin::Bin/tone.mp3", "$tempdir/b.mp3"), 0);
    my $b = Audio::TagLib::Simple::ID3v2->new( "$tempdir/b.mp3" );
    $b->add_tag($type, $value);
    $b->write();

    is(system("diff", "$tempdir/a.mp3", "$tempdir/b.mp3"), 0);
    is(MP3::Tag->new("$tempdir/a.mp3")->title, $value);
    is(MP3::Tag->new("$tempdir/b.mp3")->title, $value);
}



done_testing();
