#include "moonbit.h"
#include <driver/gpio.h>

esp_err_t __wrap_gpio_config(
    uint64_t pin_bit_mask,
    int32_t mode,
    int32_t pull_up_en,
    int32_t pull_down_en,
    int32_t intr_type)
{
    gpio_config_t io_conf = {
        .pin_bit_mask = pin_bit_mask,
        .mode = mode,
        .pull_up_en = pull_up_en,
        .pull_down_en = pull_down_en,
        .intr_type = intr_type,
    };
    return gpio_config(&io_conf);
}

esp_err_t __wrap_gpio_set_level(int gpio_num, uint32_t level)
{
    return gpio_set_level(gpio_num, level);
}
