#pragma once

#include <stdint.h>
#include <stdio.h>

struct measurement {
    float angle;
};

struct measurements;

int measurements_new(struct measurements **m, size_t capacity);
void measurements_free(struct measurements *m);

void measurements_push(struct measurements *m, struct measurement *value);
void measurements_clear(struct measurements *m);

int measurements_to_json(struct measurements *m, FILE *f);

