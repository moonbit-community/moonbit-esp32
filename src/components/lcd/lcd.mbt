// // Copyright 2025 International Digital Economy Academy
// //
// // Licensed under the Apache License, Version 2.0 (the "License");
// // you may not use this file except in compliance with the License.
// // You may obtain a copy of the License at
// //
// //     http://www.apache.org/licenses/LICENSE-2.0
// //
// // Unless required by applicable law or agreed to in writing, software
// // distributed under the License is distributed on an "AS IS" BASIS,
// // WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// // See the License for the specific language governing permissions and
// // limitations under the License.

///|
pub extern type Panel

///|
extern "C" fn _esp_lcd_panel_reset(panel : Panel) -> Int = "__wrap_esp_lcd_panel_reset"

///|
pub fn reset(self : Panel) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() { _esp_lcd_panel_reset(self) })
}

///|
extern "C" fn _esp_lcd_panel_init(panel : Panel) -> Int = "__wrap_esp_lcd_panel_init"

///|
pub fn initialize(self : Panel) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() { _esp_lcd_panel_init(self) })
}

///|
#borrow(data)
extern "C" fn _esp_lcd_panel_draw_bitmap(
  panel : Panel,
  x_start : Int,
  y_start : Int,
  x_end : Int,
  y_end : Int,
  data : FixedArray[Byte]
) -> Int = "__wrap_esp_lcd_panel_draw_bitmap"

///|
pub fn draw_bitmap(
  self : Panel,
  x_start : Int,
  y_start : Int,
  x_end : Int,
  y_end : Int,
  data : FixedArray[Byte]
) -> Unit {
  _esp_lcd_panel_draw_bitmap(self, x_start, y_start, x_end, y_end, data)
  |> ignore
}

///|
pub extern "C" fn esp_lcd_panel_mirror(
  panel : Panel,
  mirror_x : Bool,
  mirror_y : Bool
) -> Int = "__wrap_esp_lcd_panel_mirror"

///|
pub extern "C" fn esp_lcd_panel_swap_xy(panel : Panel, swap_axes : Bool) -> Int = "__wrap_esp_lcd_panel_swap_xy"

///|
pub extern "C" fn esp_lcd_panel_set_gap(
  panel : Panel,
  x_gap : Int,
  y_gap : Int
) -> Int = "__wrap_esp_lcd_panel_set_gap"

///|
extern "C" fn _esp_lcd_panel_invert_color(
  panel : Panel,
  invert_color_data : Bool
) -> Int = "__wrap_esp_lcd_panel_invert_color"

///|
pub fn invert_color(
  self : Panel,
  invert_color_data : Bool
) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() {
    _esp_lcd_panel_invert_color(self, invert_color_data)
  })
}

///|
extern "C" fn _esp_lcd_panel_disp_on_off(panel : Panel, on_off : Bool) -> Int = "__wrap_esp_lcd_panel_disp_on_off"

///|
pub fn on_off(self : Panel, on_off : Bool) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() { _esp_lcd_panel_disp_on_off(self, on_off) })
}

///|
extern "C" fn _esp_lcd_panel_disp_sleep(panel : Panel, sleep : Bool) -> Int = "__wrap_esp_lcd_panel_disp_sleep"

///|
pub fn sleep(self : Panel, sleep : Bool) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() { _esp_lcd_panel_disp_sleep(self, sleep) })
}

///|
#borrow(io_handle)
extern "C" fn _esp_lcd_new_panel_st7789(
  io_handle : Ref[ESP_LCD_PANEL_IO_HANDLE?],
  reset_gpio_num : Int,
  rgb_ele_order : Int,
  bits_per_pixel : UInt
) -> Panel = "__wrap_esp_lcd_new_panel_st7789"

///|
pub(all) enum LCD_RGB_ELEMENT_ORDER {
  RGB = 0
  BGR = 1
}

///|
fn LCD_RGB_ELEMENT_ORDER::to_int(self : LCD_RGB_ELEMENT_ORDER) -> Int = "%identity"

///|
pub fn esp_lcd_new_panel_st7789(
  io_handle~ : Ref[ESP_LCD_PANEL_IO_HANDLE?],
  reset_gpio_num~ : Int,
  rgb_ele_order~ : LCD_RGB_ELEMENT_ORDER,
  bits_per_pixel~ : UInt
) -> Panel {
  _esp_lcd_new_panel_st7789(
    io_handle,
    reset_gpio_num,
    rgb_ele_order.to_int(),
    bits_per_pixel,
  )
}

///|
pub(all) struct ESP_LCD_PANEL_IO_SPI_CONFIG {
  dc_gpio_num : Int
  cs_gpio_num : Int
  pclk_hz : UInt
  lcd_cmd_bits : Int
  lcd_param_bits : Int
  spi_mode : Int
  trans_queue_depth : Int
}

///|
extern type ESP_LCD_PANEL_IO_HANDLE

///|
#borrow(io_handle)
extern "C" fn __wrap_esp_lcd_new_panel_io_spi(
  bus : Int,
  dc_gpio_num : Int,
  cs_gpio_num : Int,
  pclk_hz : UInt,
  lcd_cmd_bits : Int,
  lcd_param_bits : Int,
  spi_mode : Int,
  trans_queue_depth : Int,
  io_handle : Ref[ESP_LCD_PANEL_IO_HANDLE?]
) -> Int = "__wrap_esp_lcd_new_panel_io_spi"

///|
pub fn esp_lcd_new_panel_io_spi(
  bus : @spi.SPI_HOST_DEVICE,
  spi_config : ESP_LCD_PANEL_IO_SPI_CONFIG,
  io_handle : Ref[ESP_LCD_PANEL_IO_HANDLE?]
) -> Int {
  __wrap_esp_lcd_new_panel_io_spi(
    bus.to_int(),
    spi_config.dc_gpio_num,
    spi_config.cs_gpio_num,
    spi_config.pclk_hz,
    spi_config.lcd_cmd_bits,
    spi_config.lcd_param_bits,
    spi_config.spi_mode,
    spi_config.trans_queue_depth,
    io_handle,
  )
}

///|
pub fn config(
  self : Panel,
  on_off~ : Bool,
  sleep~ : Bool,
  invert_color~ : Bool
) -> Unit!@error.ESPError {
  self.on_off!(on_off)
  self.sleep!(sleep)
  self.invert_color!(invert_color)
}
