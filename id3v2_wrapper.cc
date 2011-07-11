#include <tfile.h>
#include <mpegfile.h>
#include "id3v2_wrapper.h"

id3v2_wrapper_data * _wrapper_load(const char *filename) {
    id3v2_wrapper_data *data = new id3v2_wrapper_data;
    data->file = (void *) new TagLib::MPEG::File( filename );

    return data;
}
