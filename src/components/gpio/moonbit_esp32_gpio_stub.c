/*
 * // Copyright 2025 International Digital Economy Academy
 * //
 * // Licensed under the Apache License, Version 2.0 (the "License");
 * // you may not use this file except in compliance with the License.
 * // You may obtain a copy of the License at
 * //
 * //     http://www.apache.org/licenses/LICENSE-2.0
 * //
 * // Unless required by applicable law or agreed to in writing, software
 * // distributed under the License is distributed on an "AS IS" BASIS,
 * // WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * // See the License for the specific language governing permissions and
 * // limitations under the License.
 */

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
