#include <tfile.h>
#include <mpegfile.h>
#include <textidentificationframe.h>
#include <id3v2tag.h>
#include <commentsframe.h>
#include <attachedpictureframe.h>

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

void _wrapper_add_tag(Audio__TagLib__Simple__ID3v2 *data, const char *tag_name, const char *tag_value) {
    TagLib::ByteVector _type(tag_name);
    TagLib::String _value(tag_value, TagLib::String::UTF8);

    TagLib::ID3v2::TextIdentificationFrame *frame = new TagLib::ID3v2::TextIdentificationFrame(_type, TagLib::String::UTF8);
    frame->setText(_value);
    TagLib::ID3v2::Tag *tag = dynamic_cast<TagLib::MPEG::File *>(data->file)->ID3v2Tag(true);
    tag->addFrame(frame);
}

void _wrapper_add_comment(Audio__TagLib__Simple__ID3v2 *data, const char *language, const char *description, const char *text) {
    TagLib::ByteVector _language(language);
    TagLib::String _description(description, TagLib::String::UTF8);
    TagLib::String _text(text, TagLib::String::UTF8);

    TagLib::ID3v2::CommentsFrame *frame = new TagLib::ID3v2::CommentsFrame(TagLib::String::UTF8);
    frame->setLanguage(_language);
    frame->setDescription(_description);
    frame->setText(_text);
    TagLib::ID3v2::Tag *tag = dynamic_cast<TagLib::MPEG::File *>(data->file)->ID3v2Tag(true);
    tag->addFrame(frame);
}

void _wrapper_add_picture(Audio__TagLib__Simple__ID3v2 *data, const char *mime_type, const char *description, const char *picture, unsigned int length, int type) {
    TagLib::String _mime_type(mime_type, TagLib::String::UTF8);
    TagLib::String _description(mime_type, TagLib::String::UTF8);
    TagLib::ByteVector _picture(picture, length);

    TagLib::ID3v2::AttachedPictureFrame *frame = new TagLib::ID3v2::AttachedPictureFrame();
    frame->setTextEncoding(TagLib::String::UTF8);
    frame->setMimeType(_mime_type);
    frame->setDescription(_description);
    frame->setPicture(_picture);
    TagLib::ID3v2::Tag *tag = dynamic_cast<TagLib::MPEG::File *>(data->file)->ID3v2Tag(true);
    tag->addFrame(frame);
}

void _wrapper_destroy(Audio__TagLib__Simple__ID3v2 *data) {
    delete data->file;
    delete data;
}
