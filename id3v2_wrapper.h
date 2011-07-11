
#ifdef __cplusplus
extern "C" {
#endif

    typedef struct {
        void *file;
    } id3v2_wrapper_data;


    id3v2_wrapper_data * _load(const char *filename);

#ifdef __cplusplus
}
#endif

