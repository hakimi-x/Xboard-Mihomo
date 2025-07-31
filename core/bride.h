#pragma once

#include <stdlib.h>

extern void (*release_object_func)(void *obj);

extern void (*protect_func)(void *tun_interface, const int fd);

extern char* (*resolve_process_func)(void *tun_interface, const int protocol, const char *source, const char *target, const int uid);

extern char* (*result_func)(void *invoke_Interface, const char *data);

extern void protect(void *tun_interface, const int fd);

extern char* resolve_process(void *tun_interface, const int protocol, const char *source, const char *target, const int uid);

extern void release_object(void *obj);

extern char* result(void *invoke_Interface,  const char *data);