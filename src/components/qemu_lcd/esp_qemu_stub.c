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
