use 5.010001;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Audio::TagLib::ID3v2',
    VERSION_FROM      => 'lib/Audio/TagLib/ID3v2.pm', # finds $VERSION
    PREREQ_PM         => {}, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Audio/TagLib/ID3v2.pm', # retrieve abstract from module
       AUTHOR         => 'Dave Lambley <davel@state51.co.uk>') : ()),
    LIBS              => ['-libtag1'], # e.g., '-lm'
    DEFINE            => '', # e.g., '-DHAVE_SOMETHING'
    INC               => '-I.', # e.g., '-I. -I/usr/include/other'
	# Un-comment this if you add C files to link with later:
    # OBJECT            => '$(O_FILES)', # link all the C files too
    MYEXTLIB          => 'id3v2_wrapper$(LIB_EXT)',
);

sub MY::postamble {
"
\$(MYEXTLIB): id3v2_wrapper.cc Makefile
\tg++ -c id3v2_wrapper.cc -o id3v2_wrapper\$(LIB_EXT)
";
}
