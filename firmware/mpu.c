#include <i2c/i2c.h>

#include "mpu.h"

#define MPU_DEBUG true

#ifdef MPU_DEBUG
#include <stdio.h>
#define debug(fmt, ...) printf("%s: " fmt "\n", "MPU", ## __VA_ARGS__)
#else
#define debug(fmt, ...)
#endif

#define I2C_BUS 0
#define MPU_ADDR 0x68

#define MPU_REG_ACCEL_XOUT_H 0x3B
#define MPU_REG_PWR1 0x6B
#define MPU_REG_PWR2 0x6C

static int mpu_write_reg(uint8_t reg, uint8_t value) {
    int err = i2c_slave_write(I2C_BUS, MPU_ADDR, (uint8_t[]){reg}, (uint8_t[]){value}, 1);
    if (err) {
        debug("failed to write reg %d: %d", reg, err);
        return err;
    }
    return 0;
}

int mpu_init(void) {
    int err = 0;

    // Reset device.
    err = mpu_write_reg(MPU_REG_PWR1, 0x1 << 7);
    if (err) {
        return err;
    }

    // Disable temperature. Disable cycle mode. Put to sleep.
    err = mpu_write_reg(MPU_REG_PWR1, 0x1 << 6);
    if (err) {
        return err;
    }

    // Enable only accelerometer in all axes. Disable gyroscope.
    err = mpu_write_reg(MPU_REG_PWR2, 0x7);
    if (err) {
        return err;
    }

    return 0;
}

int mpu_sleep(void) {
    return mpu_write_reg(MPU_REG_PWR1, 0x1 << 6);
}

int mpu_wakeup(void) {
    return mpu_write_reg(MPU_REG_PWR1, 0x0);
}

int mpu_read_accel(struct mpu_accel *accel) {
    uint8_t buffer[6] = {0};
    int err = i2c_slave_read(I2C_BUS, MPU_ADDR, (uint8_t[]){MPU_REG_ACCEL_XOUT_H}, buffer, 6);
    if (err) {
        debug("failed to read accelerometer data: %d", err);
        return err;
    }

    accel->x = buffer[0] << 8 | buffer[1];
    accel->y = buffer[2] << 8 | buffer[3];
    accel->z = buffer[4] << 8 | buffer[5];

    return 0;
}

