#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"
#include "id3v2_wrapper.h"

MODULE = Audio::TagLib::ID3v2		PACKAGE = Audio::TagLib::ID3v2

void
_load(self, filename)
    SV  *self
    char *filename
PREINIT:
    HV *real_obj = (HV *) SvRV(self);
CODE:
    id3v2_wrapper_data *data = _wrapper_load(filename);
    hv_store(real_obj, "data", 4, data, 0);

