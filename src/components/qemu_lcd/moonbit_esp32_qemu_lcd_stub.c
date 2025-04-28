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

#include "esp_lcd_qemu_rgb.h"

//////////////

// QEME RGB LCD

struct moonbit_ref_optional_panel
{
    esp_lcd_panel_handle_t panel;
};

void *__wrap_esp_lcd_new_rgb_qemu(int32_t width, int32_t height,
                                  esp_lcd_rgb_qemu_bpp_t bpp)
{

    esp_lcd_rgb_qemu_config_t rgb_config = {
        .width = width,
        .height = height,
        .bpp = bpp,
    };
    esp_lcd_panel_handle_t panel;
    esp_err_t ret = esp_lcd_new_rgb_qemu(&rgb_config, &panel);
    return panel;
}

// TODO
// esp_err_t __wrap_esp_lcd_rgb_qemu_get_frame_buffer(void *panel, void **fb);

esp_err_t __wrap_esp_lcd_rgb_qemu_refresh(void *panel)
{
    return esp_lcd_rgb_qemu_refresh(panel);
}
