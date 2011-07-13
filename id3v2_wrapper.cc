#include <tfile.h>
#include <mpegfile.h>
#include <textidentificationframe.h>
#include <id3v2tag.h>
#include <commentsframe.h>
#include <attachedpictureframe.h>
#include <urllinkframe.h>
#include <tstringlist.h>

#include <assert.h>
#include <stdio.h>
#include <string.h>

#include "id3v2_wrapper.h"

Audio__TagLib__Simple__ID3v2 * _wrapper_load(const char *filename) {
    Audio__TagLib__Simple__ID3v2 *data = new Audio__TagLib__Simple__ID3v2;
    data->file = new TagLib::MPEG::File( filename );

    return data;
}

void _wrapper_strip_all_tags(Audio__TagLib__Simple__ID3v2 *data) {
    dynamic_cast<TagLib::MPEG::File *>(data->file)->strip( TagLib::MPEG::File::AllTags );
}

void _wrapper_write(Audio__TagLib__Simple__ID3v2 *data) {
    dynamic_cast<TagLib::MPEG::File *>(data->file)->save( TagLib::MPEG::File::AllTags );
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

void _wrapper_add_url(Audio__TagLib__Simple__ID3v2 *data, const char *tag_name, const char *text, const char *url) {
    TagLib::ByteVector _tag_name(tag_name);
    TagLib::String _text(text, TagLib::String::UTF8);
    TagLib::String _url(url, TagLib::String::UTF8);

    printf("text: %s\nurl: %s\n", text, url);

    assert(_tag_name.size() == 4);
    assert(strcmp(tag_name, "WXXX")==0);

    TagLib::ID3v2::UserUrlLinkFrame *frame = new TagLib::ID3v2::UserUrlLinkFrame();
    frame->setUrl(_url);
    frame->setText(_text);
    frame->setTextEncoding(TagLib::String::UTF8);
    TagLib::ID3v2::Tag *tag = dynamic_cast<TagLib::MPEG::File *>(data->file)->ID3v2Tag(true);
    tag->addFrame(frame);
}

void _wrapper_add_list(Audio__TagLib__Simple__ID3v2 *data, const char *tag_name, const char *list[]) {
    TagLib::ByteVector _tag_name(tag_name);
    TagLib::StringList _strings;

    const char **i = list;
    while (*i) {
        TagLib::String s(*i, TagLib::String::UTF8);
        _strings.append(s);
        i++;
    }
 
    TagLib::ID3v2::TextIdentificationFrame *frame = new TagLib::ID3v2::TextIdentificationFrame(_tag_name, TagLib::String::UTF8);
    frame->setText(_strings);
    TagLib::ID3v2::Tag *tag = dynamic_cast<TagLib::MPEG::File *>(data->file)->ID3v2Tag(true);
    tag->addFrame(frame);
   
};

void _wrapper_destroy(Audio__TagLib__Simple__ID3v2 *data) {
    delete data->file;
    delete data;
}
