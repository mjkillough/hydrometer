#include <stdlib.h>

#include <FreeRTOS.h>
#include <task.h>

#include <espressif/esp_common.h>
#include <esp/uart.h>
#include <esp8266.h>

#include <i2c/i2c.h>

#include "mpu.h"

#define I2C_BUS 0
#define SCL_PIN 2
#define SDA_PIN 0

void blink(void *pvParameters)
{
    int result = i2c_init(I2C_BUS, SCL_PIN, SDA_PIN, I2C_FREQ_100K);
    printf("i2c_init = %d\n", result);

    mpu_init();

    while(1) {
        mpu_wakeup();

        // The accelerometer data is only available in the register
        // after the I2C bus is left idle.
        vTaskDelay(100 / portTICK_PERIOD_MS);

        struct mpu_accel accel = {0};
        mpu_read_accel(&accel);

        mpu_sleep();

        printf("accel (%d, %d, %d)\n", accel.x, accel.y, accel.z);

        vTaskDelay(1000 / portTICK_PERIOD_MS);
    }
}

void user_init(void)
{
    uart_set_baud(0, 115200);

    xTaskCreate(blink, "blink", 256, NULL, 2, NULL);
}

