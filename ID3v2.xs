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
tagger_add_picture(self, _mime_type, _description, _picture, _type)
    Audio::TagLib::Simple::ID3v2 * self
    char *_mime_type
    char *_description
    char *_picture
    int _type;
CODE:
    char *mime_type = _mime_type;
    char *description = _description;
    char *picture = _picture;

    STRLEN len;
    SvPV(ST(1), len);
    if (!SvUTF8(ST(1))) mime_type = bytes_to_utf8(mime_type, &len);
    
    SvPV(ST(2), len);
    if (!SvUTF8(ST(2))) description = bytes_to_utf8(description, &len);

    // We want to make sure that the picture *isn't* UTF8 encoded.
    bool conv = SvUTF8(ST(3))!=0;
    SvPV(ST(3), len);
    picture = bytes_from_utf8(picture, &len, &conv);

    _wrapper_add_picture(self, mime_type, description, picture, len, _type);

    if (mime_type != _mime_type) Safefree(mime_type);
    if (description != _description) Safefree(description);
    if (picture != _picture) Safefree(picture);

void
tagger_add_url(self, _tag_name, _text, _url)
    Audio::TagLib::Simple::ID3v2 * self
    char *_tag_name
    char *_text
    char *_url
CODE:
    char *tag_name = _tag_name;
    char *text = _text;
    char *url = _url;


    STRLEN len;
    SvPV(ST(1), len);
    if (!SvUTF8(ST(1))) tag_name  = bytes_to_utf8(tag_name, &len);
    
    SvPV(ST(2), len);
    if (!SvUTF8(ST(2))) text = bytes_to_utf8(text, &len);

    SvPV(ST(3), len);
    if (!SvUTF8(ST(3))) url = bytes_to_utf8(url, &len);

    printf("starting with url %s\n", url);
    _wrapper_add_url(self, tag_name, text, url);

    if (tag_name != _tag_name) Safefree(tag_name);
    if (text != _text) Safefree(text);
    if (url != _url) Safefree(url);

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

