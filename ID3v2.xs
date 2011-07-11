#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"
#include "id3v2_wrapper.h"

MODULE = Audio::TagLib::ID3v2		PACKAGE = Audio::TagLib::ID3v2      PREFIX = tagger_
PROTOTYPES: ENABLE

Audio::TagLib::ID3v2 *
tagger_new(package, filename)
    char *package
    char *filename
CODE:
    RETVAL = _wrapper_load(filename);
OUTPUT:
    RETVAL

