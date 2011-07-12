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
    char *_name
    char *_value
CODE:
    char *name = _name;
    char *value = _value;

    STRLEN len;
    SvPV(ST(1), len);
    if (!SvUTF8(ST(1))) name  = bytes_to_utf8(name, &len);
    
    SvPV(ST(2), len);
    if (!SvUTF8(ST(2))) value = bytes_to_utf8(value, &len);

    _wrapper_add_tag(self, name, value);

    if (name  != _name) Safefree(name);
    if (value != _value) Safefree(value);

void
tagger_add_comment(self, _language, _description, _text)
    Audio::TagLib::Simple::ID3v2 * self
    char *_language
    char *_description
    char *_text
CODE:
    char *language = _language;
    char *description = _description;
    char *text = _text;

    STRLEN len;
    SvPV(ST(1), len);
    if (!SvUTF8(ST(1))) language  = bytes_to_utf8(language, &len);
    
    SvPV(ST(2), len);
    if (!SvUTF8(ST(2))) description = bytes_to_utf8(description, &len);

    SvPV(ST(3), len);
    if (!SvUTF8(ST(3))) text = bytes_to_utf8(text, &len);

    _wrapper_add_comment(self, language, description, text);

    if (language != _language) Safefree(language);
    if (description != _description) Safefree(description);
    if (text != _text) Safefree(text);

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

