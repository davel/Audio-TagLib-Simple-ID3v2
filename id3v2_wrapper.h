
#ifdef __cplusplus
extern "C" {
    typedef struct {
        TagLib::File *file;
    } Audio__TagLib__Simple__ID3v2;


#else
    typedef struct Audio__TagLib__Simple__ID3v2 Audio__TagLib__Simple__ID3v2;
#endif


    Audio__TagLib__Simple__ID3v2 * _wrapper_load(const char *filename);
    void _wrapper_strip_all_tags(Audio__TagLib__Simple__ID3v2 *data);
    void _wrapper_write(Audio__TagLib__Simple__ID3v2 *data);
    void _wrapper_add_tag(Audio__TagLib__Simple__ID3v2 *data, const char *tag_name, const char *tag_value);
    void _wrapper_add_comment(Audio__TagLib__Simple__ID3v2 *data, const char *language, const char *description, const char *text);
    void _wrapper_add_picture(Audio__TagLib__Simple__ID3v2 *data, const char *mime_type, const char *description, const char *picture, unsigned int length, int type);
    void _wrapper_destroy(Audio__TagLib__Simple__ID3v2 *data);
    void _wrapper_add_url(Audio__TagLib__Simple__ID3v2 *data, const char *tag_name, const char *text, const char *url);
    void _wrapper_add_list(Audio__TagLib__Simple__ID3v2 *data, const char *tag_name, const char *list[]);

#ifdef __cplusplus
}
#endif

