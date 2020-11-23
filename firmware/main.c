#include <stdlib.h>
#include <math.h>

#include <FreeRTOS.h>
#include <task.h>

#include <espressif/esp_common.h>
#include <esp/uart.h>
#include <esp8266.h>

#include <i2c/i2c.h>
#include <ssid_config.h>

#include "mpu.h"
#include "http.h"

#define I2C_BUS 0
#define SCL_PIN 2
#define SDA_PIN 0

#define HYDROMETER_DEBUG true

#ifdef HYDROMETER_DEBUG
#include <stdio.h>
#define debug(fmt, ...) printf("%s: " fmt "\n", "HYDROMETER", ## __VA_ARGS__)
#else
#define debug(fmt, ...)
#endif

int measure_angle(float *angle) {
    int err = 0;

    err = mpu_wakeup();
    if (err) {
        debug("failed to wake-up mpu: %d", err);
        return err;
    }

    // The accelerometer data is only available in the register
    // after the I2C bus is left idle.
    vTaskDelay(10 / portTICK_PERIOD_MS);

    struct mpu_accel a = {0};
    err = mpu_read_accel(&a);
    if (err) {
        debug("failed to read accel: %d", err);
        return err;
    }

    err = mpu_sleep();
    if (err) {
        debug("failed to put mpu to sleep: %d", err);
        return err;
    }

    *angle = acos(a.z / sqrt(a.x * a.x + a.y * a.y + a.z * a.z)) * 180.0 / M_PI;

    return 0;
}

void blink(void *pvParameters)
{
    vTaskDelay(10000 / portTICK_PERIOD_MS);

    int result = i2c_init(I2C_BUS, SCL_PIN, SDA_PIN, I2C_FREQ_100K);
    printf("i2c_init = %d\n", result);

    mpu_init();

    while(1) {
        /* float angle = 0; */
        /* measure_angle(&angle); */
        /* printf("angle = %f\n", angle); */

        struct http_request req = {
            .hostname = "192.168.86.92",
            .port = "8080",
            .path = "/path",
            .len = 5,
            .body = "Hello",
        };
        struct http_response resp = {0};
        int err = http_post(&req, &resp);
        printf("err = %d\n", err);
        printf("status = %d\n", resp.status_code);

        vTaskDelay(1000 / portTICK_PERIOD_MS);
    }
}

void user_init(void)
{
    uart_set_baud(0, 115200);

    struct sdk_station_config config = {
        .ssid = WIFI_SSID,
        .password = WIFI_PASS,
    };
    sdk_wifi_set_opmode(STATION_MODE);
    sdk_wifi_station_set_config(&config);

    xTaskCreate(blink, "blink", 384, NULL, 2, NULL);
}

