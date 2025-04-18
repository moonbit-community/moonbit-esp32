#include "esp_lcd_qemu_rgb.h"
#include <esp_lcd_panel_ops.h>

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

//////////////

// QEME RGB LCD

struct moonbit_ref_panel {
  esp_lcd_panel_handle_t panel;
}

esp_err_t
__wrap_esp_lcd_new_rgb_qemu(int32_t width, int32_t height,
                            esp_lcd_rgb_qemu_bpp_t bpp,
                            struct moonbit_ref_panel *ret_panel) {

  struct esp_lcd_rgb_qemu_config_t rgb_config = {
      .width = width,
      .height = height,
      .bpp = bpp,
  };
  esp_lcd_panel_handle_t panel;
  esp_err_t ret = esp_lcd_new_rgb_qemu(&rgb_config, &panel);
  *ret_panel = panel;
  return ret;
}

// TODO
// esp_err_t __wrap_esp_lcd_rgb_qemu_get_frame_buffer(void *panel, void **fb);

esp_err_t __wrap_esp_lcd_rgb_qemu_refresh(void *panel) {
  return esp_lcd_rgb_qemu_refresh(panel);
}
