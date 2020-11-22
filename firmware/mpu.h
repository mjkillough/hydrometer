#pragma once

#include <stdint.h>

struct mpu_accel {
    int16_t x;
    int16_t y;
    int16_t z;
};

int mpu_init(void);

int mpu_sleep(void);
int mpu_wakeup(void);

int mpu_read_accel(struct mpu_accel *accel);

