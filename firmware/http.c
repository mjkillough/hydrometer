#define _GNU_SOURCE // asprintf
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>

#include <lwip/err.h>
#include <lwip/sockets.h>
#include <lwip/sys.h>
#include <lwip/netdb.h>
#include <lwip/dns.h>
#include <http-parser/http_parser.h>

#include "http.h"

#define HTTP_DEBUG true

#ifdef HTTP_DEBUG
#define debug(fmt, ...) printf("%s: " fmt "\n", "HTTP", ## __VA_ARGS__)
#else
#define debug(fmt, ...)
#endif

// Size of buffer responses are read into.
#define BUFFER_LEN 1024

static int http_connect(struct http_request *req, int *fd) {
    int err = 0;

    const struct addrinfo hints = {
        .ai_family = AF_UNSPEC,
        .ai_socktype = SOCK_STREAM,
    };

    struct addrinfo *addrinfo;
    err = getaddrinfo(req->hostname, req->port, &hints, &addrinfo);
    if (err != 0 || !addrinfo) {
        debug("dns lookup failed: err=%d, addrinfo=%p", err, addrinfo);
        goto done;
    }

    *fd = socket(addrinfo->ai_family, addrinfo->ai_socktype, 0);
    if (*fd < 0) {
        debug("failed to allocate socket: %d", errno);
        err = -errno;
        goto done;
    }

    err = connect(*fd, addrinfo->ai_addr, addrinfo->ai_addrlen);
    if (err) {
        debug("failed to connect: %d", errno);
        err = -errno;
        goto done;
    }

done:
    if (addrinfo) {
        freeaddrinfo(addrinfo);
    }
    return err;
}

static int writeall(int fd, const void *buf, size_t count) {
    while (count > 0) {
        ssize_t written = write(fd, buf, count);
        if (written < 0) {
            return -errno;
        }
        buf += written;
        count -= written;
    }
    return 0;
}

static int http_on_headers_complete(struct http_parser *parser) {
    struct http_response *resp = parser->data;
    resp->status_code = parser->status_code;
    return 0;
}

static int http_read_response(int fd, struct http_response *resp) {
    int err = 0;
    http_parser *parser = NULL;
    char *buf = NULL;

    parser = malloc(sizeof(http_parser));
    if (!parser) {
        debug("failed to allocate http_parser");
        goto done;
    }

    http_parser_init(parser, HTTP_RESPONSE);
    parser->data = resp;

    http_parser_settings settings = {
        .on_headers_complete = http_on_headers_complete,
    };

    buf = malloc(BUFFER_LEN);
    if (!buf) {
        debug("failed to allocate buffer to read reponse");
        goto done;
    }

    size_t parsed = 0;
    do {
        ssize_t recved = recv(fd, buf, BUFFER_LEN, 0);
        if (recved < 0) {
            debug("error reading response: %d", errno);
            err = -errno;
            goto done;
        }

        parsed = http_parser_execute(parser, &settings, buf, recved);

        if (parser->http_errno != HPE_OK || parsed != recved) {
            debug(
                "error parsing response: %s: %s",
                http_errno_name(parser->http_errno),
                http_errno_description(parser->http_errno)
            );
            err = -parser->http_errno;
            goto done;
        }
    } while (parsed);

done:
    free(parser);
    free(buf);
    return err;
}

int http_post(struct http_request *req, struct http_response *resp) {
    int err = 0;
    char *headers = NULL;

    int fd = 0;
    err = http_connect(req, &fd);
    if (err) {
        debug("failed to connect: %d", err);
        goto done;
    }

    asprintf(
        &headers,
        "POST %s HTTP/1.1\r\n"
        "Host: %s\r\n"
        "User-Agent: hydrometer/0.1 esp-open-rtos esp8266\r\n"
        "Connection: close\r\n"
        "Content-Length: %d\r\n"
        "\r\n",
        req->path,
        req->hostname,
        req->len
    );
    err = writeall(fd, headers, strlen(headers));
    if (err) {
        debug("error writing headers: %d", err);
        goto done;
    }

    err = writeall(fd, req->body, req->len);
    if (err) {
        debug("error writing body: %d", err);
        goto done;
    }

    err = http_read_response(fd, resp);
    if (err) {
        debug("error reading response: %d", err);
        goto done;
    }

done:
    free(headers);
    if (fd) {
        close(fd);
    }
    return err;
}

