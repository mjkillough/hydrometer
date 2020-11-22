#include <stdlib.h>

#include <FreeRTOS.h>
#include <task.h>

#include <espressif/esp_common.h>
#include <esp/uart.h>
#include <esp8266.h>

const int gpio = 2;

void blink(void *pvParameters)
{
    gpio_enable(gpio, GPIO_OUTPUT);

    while(1) {
        gpio_write(gpio, 1);
        vTaskDelay(1000 / portTICK_PERIOD_MS);
        gpio_write(gpio, 0);
        vTaskDelay(1000 / portTICK_PERIOD_MS);
    }
}

void user_init(void)
{
    uart_set_baud(0, 115200);

    xTaskCreate(blink, "blink", 256, NULL, 2, NULL);
}

