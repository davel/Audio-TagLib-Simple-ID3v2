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
tagger_add_tag(self, _name, _value)
    Audio::TagLib::Simple::ID3v2 * self
    const char *_name
    const char *_value
CODE:
    char *name = _name;
    char *value = _value;

    bool conv;

    STRLEN len;
    SvPV(ST(1), len);
    if (!SvUTF8(ST(1))) name  = bytes_to_utf8(name, &len);
    
    SvPV(ST(2), len);
    if (!SvUTF8(ST(2))) value = bytes_to_utf8(value, &len);

    _wrapper_add_tag(self, name, value);

    if (name  != _name) Safefree(name);
    if (value != _value) Safefree(value);

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

