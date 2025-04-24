#include "esp_err.h"
#include "esp_lcd_panel_io.h"
#include "esp_lcd_panel_ops.h"
#include "esp_lcd_panel_vendor.h"
#include "esp_lcd_qemu_rgb.h"
#include "esp_lcd_types.h"
#include <esp_lcd_io_spi.h>

esp_err_t __wrap_esp_lcd_panel_reset(void *panel) {
  return esp_lcd_panel_reset(panel);
}

esp_err_t __wrap_esp_lcd_panel_init(void *panel) {
  return esp_lcd_panel_init(panel);
}

esp_err_t __wrap_esp_lcd_panel_del(void *panel) {
  return esp_lcd_panel_del(panel);
}

esp_err_t __wrap_esp_lcd_panel_draw_bitmap(void *panel, int x_start,
                                           int y_start, int x_end, int y_end,
                                           const void *color_data) {
  return esp_lcd_panel_draw_bitmap(panel, x_start, y_start, x_end, y_end,
                                   color_data);
}

esp_err_t __wrap_esp_lcd_panel_mirror(void *panel, bool mirror_x,
                                      bool mirror_y) {
  return esp_lcd_panel_mirror(panel, mirror_x, mirror_y);
}

esp_err_t __wrap_esp_lcd_panel_swap_xy(void *panel, bool swap_axes) {
  return esp_lcd_panel_swap_xy(panel, swap_axes);
}

esp_err_t __wrap_esp_lcd_panel_set_gap(void *panel, int x_gap, int y_gap) {
  return esp_lcd_panel_set_gap(panel, x_gap, y_gap);
}

esp_err_t __wrap_esp_lcd_panel_invert_color(void *panel,
                                            bool invert_color_data) {
  return esp_lcd_panel_invert_color(panel, invert_color_data);
}

esp_err_t __wrap_esp_lcd_panel_disp_on_off(void *panel, bool on_off) {
  return esp_lcd_panel_disp_on_off(panel, on_off);
}

esp_err_t __wrap_esp_lcd_panel_disp_sleep(void *panel, bool sleep) {
  return esp_lcd_panel_disp_sleep(panel, sleep);
}

esp_err_t
__wrap_esp_lcd_new_panel_io_spi(int32_t bus,

                                int32_t dc_gpio_num, int32_t cs_gpio_num,
                                uint32_t pclk_hz, int32_t lcd_cmd_bits,
                                int32_t lcd_param_bits, int32_t spi_mode,
                                uint32_t trans_queue_depth,

                                esp_lcd_panel_io_handle_t *io_handle) {

  esp_lcd_panel_io_spi_config_t io_config = {
      .dc_gpio_num = dc_gpio_num,
      .cs_gpio_num = cs_gpio_num,
      .pclk_hz = pclk_hz,
      .lcd_cmd_bits = lcd_cmd_bits,
      .lcd_param_bits = lcd_param_bits,
      .spi_mode = spi_mode,
      .trans_queue_depth = trans_queue_depth,
  };

  esp_lcd_new_panel_io_spi(bus, &io_config, io_handle);
}

esp_lcd_panel_handle_t
__wrap_esp_lcd_new_panel_st7789(esp_lcd_panel_io_handle_t *io_handle,
                                int32_t reset_gpio_num, int32_t rgb_ele_order,
                                uint32_t bits_per_pixel) {
  esp_lcd_panel_dev_config_t panel_config = {
      .reset_gpio_num = reset_gpio_num,
      .rgb_ele_order = rgb_ele_order,
      .bits_per_pixel = bits_per_pixel,
  };

  esp_lcd_panel_handle_t panel_handle;
  esp_err_t ret =
      esp_lcd_new_panel_st7789(*io_handle, &panel_config, &panel_handle);
  return panel_handle;
}

//////////////

// QEME RGB LCD

struct moonbit_ref_optional_panel {
  esp_lcd_panel_handle_t panel;
};

void *__wrap_esp_lcd_new_rgb_qemu(int32_t width, int32_t height,
                                  esp_lcd_rgb_qemu_bpp_t bpp) {

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

esp_err_t __wrap_esp_lcd_rgb_qemu_refresh(void *panel) {
  return esp_lcd_rgb_qemu_refresh(panel);
}
