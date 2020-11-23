#pragma once

#include <stdint.h>

struct http_request {
    const char *hostname;
    const char *port;
    const char *path;

    const char *content_type;
    const size_t len;
    const char *body;
};

struct http_response {
    int status_code;
};

int http_post(struct http_request *req, struct http_response *resp);

