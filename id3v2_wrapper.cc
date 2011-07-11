#include <tfile.h>
#include <mpegfile.h>
#include "id3v2_wrapper.h"

Audio__TagLib__ID3v2 * _wrapper_load(const char *filename) {
    Audio__TagLib__ID3v2 *data = new Audio__TagLib__ID3v2;
    data->file = (void *) new TagLib::MPEG::File( filename );

    return data;
}
