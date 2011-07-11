#include <tfile.h>
#include <mpegfile.h>
#include <textidentificationframe.h>
#include "id3v2_wrapper.h"
#include <stdio.h>

Audio__TagLib__Simple__ID3v2 * _wrapper_load(const char *filename) {
    Audio__TagLib__Simple__ID3v2 *data = new Audio__TagLib__Simple__ID3v2;
    data->file = new TagLib::MPEG::File( filename );

    return data;
}

void _wrapper_strip_all_tags(Audio__TagLib__Simple__ID3v2 *data) {
    dynamic_cast<TagLib::MPEG::File *>(data->file)->strip( TagLib::MPEG::File::AllTags );
    printf("stripped!");
}

void _wrapper_write(Audio__TagLib__Simple__ID3v2 *data) {
    dynamic_cast<TagLib::MPEG::File *>(data->file)->save( TagLib::MPEG::File::AllTags );
    printf("save!");
}

void add_tag(Audio__TagLib__Simple__ID3v2 *data, const char *tag_name, const char *tag_value, int utf8) {
    TagLib::ByteVector _type(tag_name);
    TagLib::String _value(tag_value, utf8 ? TagLib::String::UTF8 : TagLib::String::Latin1);

    TagLib::ID3v2::TextIdentificationFrame *frame = new TagLib::ID3v2::TextIdentificationFrame(_type);
    frame->setText(_value);
//    dynamic_cast<TagLib::MPEG::File *>(data->file)->ID3v2Tag(true)->addFrame(frame);
}
