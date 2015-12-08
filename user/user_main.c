#include <stddef.h>
#include <stdint.h>

#include "freertos/FreeRTOS.h"
#include "freertos/task.h"

#include "esp_common.h"
#include "esp_wifi.h"

#include "uart.h"

#include "user_config.h"

static void user_setup(void);
static void wifi_handle_event_cb(System_Event_t *event);
static void helloworld(void *pvParameters);

void ICACHE_FLASH_ATTR user_init(void)
{
    user_setup();

    xTaskCreate(helloworld, "hw", configMINIMAL_STACK_SIZE, NULL, 2, NULL);
}

static void user_setup(void)
{
    /* initialize UART */
    uart_div_modify(UART0, UART_CLK_FREQ / (BIT_RATE_9600));

    /* initialize WiFi */
    wifi_set_opmode(STATION_MODE);
    struct station_config * config = (struct station_config *)zalloc(sizeof(struct station_config));
    sprintf(config->ssid, DEMO_AP_SSID);
    sprintf(config->password, DEMO_AP_PASSWORD);
    wifi_station_set_config(config);
    wifi_set_event_handler_cb(wifi_handle_event_cb);
    free(config);
    wifi_station_connect();

}

static void wifi_handle_event_cb(System_Event_t *event)
{
 if (event->event_id == EVENT_STAMODE_GOT_IP)
 {
   printf("Got IP! ip:" IPSTR ", mask:" IPSTR ", gw:" IPSTR " \n",
     IP2STR(&event->event_info.got_ip.ip),
     IP2STR(&event->event_info.got_ip.mask),
     IP2STR(&event->event_info.got_ip.gw));
 }
}

static void helloworld(void *pvParameters)
{
    const portTickType xDelay = 1000 / portTICK_RATE_MS;
    for(;;)
    {
        printf("Hello World!\n");
        vTaskDelay(xDelay);
    }
}

