#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>

#include "measurements.h"

#define MEASUREMENTS_DEBUG true

#ifdef MEASUREMENTS_DEBUG
#include <stdio.h>
#define debug(fmt, ...) printf("%s: " fmt "\n", "MEASUREMENTS", ## __VA_ARGS__)
#else
#define debug(fmt, ...)
#endif

static int measurement_to_json(struct measurement *m, FILE *f) {
    int err = fprintf(f, "\t{\"angle\": %f, \"temp\": %f}", m->angle, m->temp);
    if (err < 0) {
        return err;
    }
    return 0;
}

// Circular buffer of measurements. Overwrites old measurements when full.
struct measurements {
    size_t capacity;
    size_t next;
    bool full;
    struct measurement *data;
};

int measurements_new(struct measurements **m, size_t capacity) {
    struct measurement *data = calloc(capacity, sizeof(*data));
    if (!data) {
        debug("failed to allocate measurements data");
        return -1;
    }

    *m = malloc(sizeof(struct measurements));
    if (!*m) {
        debug("failed to allocate struct measurements");
        return -1;
    }

    **m = (struct measurements){
        .capacity = capacity,
        .next = 0,
        .full = false,
        .data = data
    };

    return 0;
}

void measurements_free(struct measurements *m) {
    free(m->data);
    free(m);
}

void measurements_push(struct measurements *m, struct measurement *value) {
    m->data[m->next] = *value;

    m->next += 1;
    if (m->next >= m->capacity) {
        m->next = 0;
        m->full = true;
    }
}

static size_t measurements_len(struct measurements *m) {
    return m->full ? m->capacity : m->next;
}

static void measurements_get(struct measurements *m, size_t i, struct measurement **ptr) {
    size_t start = m->full ? m->next : 0;
    i = (start + i) % m->capacity;
    *ptr = &m->data[i];
}

void measurements_clear(struct measurements *m) {
    m->next = 0;
    m->full = 0;
}

int measurements_to_json(struct measurements *m, FILE *f) {
    int err = 0;
    struct measurement* ptr = NULL;

    err = fprintf(f, "[\n");
    if (err < 0) {
        return err;
    }

    size_t len = measurements_len(m);
    for (size_t i = 0; i < len; i++) {
        measurements_get(m, i, &ptr);

        err = fprintf(f, "\t");
        if (err < 0) {
            return err;
        }

        err = measurement_to_json(ptr, f);
        if (err) {
            return err;
        }

        if (i != (len - 1)) {
            err = fprintf(f, ",");
            if (err < 0) {
                return err;
            }
        }

        err = fprintf(f, "\n");
        if (err < 0) {
            return err;
        }
    }

    err = fprintf(f, "]\n");
    if (err < 0) {
        return err;
    }

    return 0;
}
