#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"
#include "id3v2_wrapper.h"

MODULE = Audio::TagLib::ID3v2		PACKAGE = Audio::TagLib::ID3v2

void
say_hello()
CODE:
    hello();


