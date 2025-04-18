///|
pub extern type Panel

///|
/// 
pub enum ESP_LCD_RGB_QEMU_BPP {
  BPP_32 = 32
  BPP_16 = 16
}

///|
pub extern "C" fn esp_lcd_panel_reset(panel : Panel) -> @error.ESPError = "__wrap_esp_lcd_panel_reset"

///|
pub extern "C" fn esp_lcd_panel_init(panel : Panel) -> @error.ESPError = "__wrap_esp_lcd_panel_init"

///|
#borrow(data)
pub extern "C" fn esp_lcd_panel_draw_bitmap(
  panel : Panel,
  x_start : Int,
  y_start : Int,
  x_end : Int,
  y_end : Int,
  data : Bytes
) -> @error.ESPError = "__wrap_esp_lcd_panel_draw_bitmap"

///|
pub extern "C" fn esp_lcd_panel_mirror(
  panel : Panel,
  mirror_x : Bool,
  mirror_y : Bool
) -> @error.ESPError = "__wrap_esp_lcd_panel_mirror"

///|
pub extern "C" fn esp_lcd_panel_swap_xy(
  panel : Panel,
  swap_axes : Bool
) -> @error.ESPError = "__wrap_esp_lcd_panel_swap_xy"

///|
pub extern "C" fn esp_lcd_panel_set_gap(
  panel : Panel,
  x_gap : Int,
  y_gap : Int
) -> @error.ESPError = "__wrap_esp_lcd_panel_set_gap"

///|
pub extern "C" fn esp_lcd_panel_invert_color(
  panel : Panel,
  invert_color_data : Bool
) -> @error.ESPError = "__wrap_esp_lcd_panel_invert_color"

///|
pub extern "C" fn esp_lcd_panel_disp_on_off(
  panel : Panel,
  on_off : Bool
) -> @error.ESPError = "__wrap_esp_lcd_panel_disp_on_off"

///|
pub extern "C" fn esp_lcd_panel_disp_sleep(
  panel : Panel,
  sleep : Bool
) -> @error.ESPError = "__wrap_esp_lcd_panel_disp_sleep"

// qemu rgb lcd

///|
#borrow(ret_panel)
pub extern "C" fn esp_lcd_new_rgb_qemu(
  width : Int,
  height : Int,
  bpp : ESP_LCD_RGB_QEMU_BPP,
  ret_panel : Ref[Panel]
) -> Panel = "__wrap_esp_lcd_new_rgb_qemu"

///|
pub extern "C" fn esp_lcd_rgb_qemu_refresh(panel : Panel) -> @error.ESPError = "__wrap_esp_lcd_rgb_qemu_refresh"
