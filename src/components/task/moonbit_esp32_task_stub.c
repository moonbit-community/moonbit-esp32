#include <stdint.h>
#include <freertos/FreeRTOS.h>
#include <freertos/task.h>

int32_t __wrap_xTaskCreate(
    void *pxTaskCode,
    uint8_t *pcName,
    uint32_t usStackDepth,
    uint32_t uxPriority)
{
    int32_t ret = xTaskCreate(pxTaskCode, (char *)pcName, usStackDepth, NULL, uxPriority, NULL);
    return ret;
}

void __wrap_vTaskDelay(int32_t xTicksToDelay)
{
    vTaskDelay(xTicksToDelay);
}

int32_t __wrap_pdMS_TO_TICKS(int32_t xTimeInMs)
{
    return pdMS_TO_TICKS(xTimeInMs);
}
