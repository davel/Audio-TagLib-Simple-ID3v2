#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use FindBin;
use File::Temp qw/ tempdir /;
use MP3::Tag;
use File::Slurp;
use Data::Dumper;

use Audio::TagLib::Simple::ID3v2;

my $tempdir = tempdir( CLEANUP => 1 );
my $packshot = File::Slurp::slurp("$FindBin::Bin/pic.png");

{
    is(system("cp", "--", "$FindBin::Bin/tone.mp3", "$tempdir/a.mp3"), 0);
    my $o = Audio::TagLib::Simple::ID3v2->new( "$tempdir/a.mp3" );
    isa_ok($o, 'Audio::TagLib::Simple::ID3v2Ptr');
    $o->strip_all_tags();
    $o->add_tag("TIT2", "hello world\x{2603}!");
    $o->add_comment("ENG", "foo", "blah");
    $o->add_comment("ENG", "", "XYZZY");
    $o->add_comment("ENG", "bar", "blah");

    # TODO - believed broken, or MP3::Tag is very broken.
    $o->add_url("WXXX", "Buy stuff", "http://www.state51.co.uk/");
    $o->add_list("TIPL", Roadie => "Dave\x{2603}", Chef => "Gary");
    $o->write();

    undef $o;

    my $m = MP3::Tag->new("$tempdir/a.mp3");
    is($m->title, "hello world\x{2603}!");
    is($m->{ID3v2}->comment, "XYZZY");

    is_deeply(
        [ $m->{ID3v2}->get_frame('COMM') ],
        [
            {
                Language => 'ENG',
                Description => 'foo',
                Text => 'blah',
                encoding => 3,
            },
            'Comments',
            {
                Language => 'ENG',
                Description => '',
                Text => 'XYZZY',
                encoding => 3,
            },
            {
                Language => 'ENG',
                Description => 'bar',
                Text => 'blah',
                encoding => 3,
            },
        ]
    );
    is_deeply(
        [ $m->{ID3v2}->get_frame("TIPL") ],
        [
            "Roadie / Dave\x{2603} / Chef / Gary",
            'Involved people list',
        ]
    );
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

{
    my $desc = "cover art";
    my $p = $packshot;

    utf8::downgrade($desc);
    utf8::downgrade($p);
    ok !utf8::is_utf8($desc);
    ok !utf8::is_utf8($p);

    is(system("cp", "--", "$FindBin::Bin/tone.mp3", "$tempdir/a.mp3"), 0);
    my $a = Audio::TagLib::Simple::ID3v2->new( "$tempdir/a.mp3" );
    $a->add_picture("image/png", $desc, $p, 0x03);
    $a->write();

    utf8::upgrade($desc);
    utf8::upgrade($p);
    ok utf8::is_utf8($desc);
    ok utf8::is_utf8($p);

    is(system("cp", "--", "$FindBin::Bin/tone.mp3", "$tempdir/b.mp3"), 0);
    my $b = Audio::TagLib::Simple::ID3v2->new( "$tempdir/b.mp3" );
    $b->add_picture("image/png", $desc, $p, 0x03);
    $b->write();

    is(system("diff", "$tempdir/a.mp3", "$tempdir/b.mp3"), 0);
}


done_testing();
