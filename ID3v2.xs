#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"
#include "id3v2_wrapper.h"

MODULE = Audio::TagLib::Simple::ID3v2Ptr		PACKAGE = Audio::TagLib::Simple::ID3v2Ptr      PREFIX = tagger_
PROTOTYPES: ENABLE

void
tagger_strip_all_tags(self)
    Audio::TagLib::Simple::ID3v2 * self
CODE:
    _wrapper_strip_all_tags(self);

void
tagger_write(self)
    Audio::TagLib::Simple::ID3v2 * self
CODE:
    _wrapper_write(self);

void
tagger_add_tag(self, name, value)
    Audio::TagLib::Simple::ID3v2 * self
    char *name
    char *value
CODE:
    _wrapper_add_tag(self, name, value, SvUTF8(ST(1)), SvUTF8(ST(2)));

void
tagger_DESTROY(self)
    Audio::TagLib::Simple::ID3v2 * self
CODE:
    _wrapper_destroy(self);


MODULE = Audio::TagLib::Simple::ID3v2		PACKAGE = Audio::TagLib::Simple::ID3v2      PREFIX = tagger_
PROTOTYPES: ENABLE

Audio::TagLib::Simple::ID3v2 *
tagger_new(package, filename)
    char *package
    char *filename
CODE:
    RETVAL = _wrapper_load(filename);
OUTPUT:
    RETVAL

