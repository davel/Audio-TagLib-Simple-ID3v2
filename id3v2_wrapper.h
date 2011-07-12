
#ifdef __cplusplus
extern "C" {
    typedef struct {
        TagLib::File::File *file;
    } Audio__TagLib__Simple__ID3v2;


#else
    typedef struct Audio__TagLib__Simple__ID3v2 Audio__TagLib__Simple__ID3v2;
#endif


    Audio__TagLib__Simple__ID3v2 * _wrapper_load(const char *filename);
    void _wrapper_strip_all_tags(Audio__TagLib__Simple__ID3v2 *data);
    void _wrapper_write(Audio__TagLib__Simple__ID3v2 *data);
    void _wrapper_add_tag(Audio__TagLib__Simple__ID3v2 *data, const char *tag_name, const char *tag_value, bool type_utf8, bool value_utf8);
    void _wrapper_destroy(Audio__TagLib__Simple__ID3v2 *data);

#ifdef __cplusplus
}
#endif

