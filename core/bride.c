#include "bride.h"

void (*release_object_func)(void *obj);

void (*protect_func)(void *tun_interface, const int fd);

char* (*resolve_process_func)(void *tun_interface,const int protocol, const char *source, const char *target, const int uid);

char* (*result_func)(void *invoke_Interface, const char *data);

void protect(void *tun_interface, const int fd) {
    protect_func(tun_interface, fd);
}

char* resolve_process(void *tun_interface, const int protocol, const char *source, const char *target, const int uid) {
    return resolve_process_func(tun_interface, protocol, source, target, uid);
}

void release_object(void *obj) {
    release_object_func(obj);
}

char* result(void *invoke_Interface, const char *data) {
    return result_func(invoke_Interface, data);
}