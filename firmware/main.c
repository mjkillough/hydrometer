#include <stdlib.h>
#include <math.h>
#include <string.h>

#include <FreeRTOS.h>
#include <task.h>

#include <espressif/esp_common.h>
#include <esp/uart.h>
#include <esp8266.h>

#include <i2c/i2c.h>
#include <ssid_config.h>

#include "measurements.h"
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

static int make_measurements(struct measurements *m) {
    int err = 0;

    float angle = 0;
    err = measure_angle(&angle);
    if (err) {
        debug("couldn't measure angle: %d", err);
        return err;
    }

    measurements_push(m, &(struct measurement){.angle = angle});

    return 0;
}

static int send_measurements(struct measurements *m) {
    int err = 0;
    char *buffer = NULL;
    size_t len = 0;

    FILE *f = open_memstream(&buffer, &len);
    if (f == NULL) {
        debug("open_memstream: %s", strerror(errno));
        err = -errno;
        goto done;
    }

    err = measurements_to_json(m, f);
    if (err) {
        goto done;
    }

    fflush(f);

    struct http_request req = {
        .hostname = "192.168.86.92",
        .port = "8080",
        .path = "/path",

        .content_type = "application/json",
        .len = len,
        .body = buffer,
    };
    struct http_response resp = {0};

    err = http_post(&req, &resp);
    if (err) {
        debug("failed to make http request: %d", err);
        goto done;
    }

    if (http_is_success(&resp)) {
        measurements_clear(m);
    } else {
        debug("got non-successful response: status=%d", resp.status_code);
    }

done:
    if (f != NULL) {
        fclose(f);
    }
    free(buffer);
    return err;
}

void blink(void *pvParameters)
{
    vTaskDelay(10000 / portTICK_PERIOD_MS);

    struct measurements *m = NULL;
    measurements_new(&m, 5);

    int result = i2c_init(I2C_BUS, SCL_PIN, SDA_PIN, I2C_FREQ_100K);
    printf("i2c_init = %d\n", result);

    mpu_init();

    int err = 0;
    while(1) {
        err = make_measurements(m);
        if (err) {
            debug("make_measurements error: %d", err);
        }

        err = send_measurements(m);
        if (err) {
            debug("send_measurements error: %d", err);
        }

        vTaskDelay(1000 / portTICK_PERIOD_MS);
    }

    measurements_free(m);
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

