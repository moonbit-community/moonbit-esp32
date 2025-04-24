///|
pub(all) enum ESP_LCD_RGB_QEMU_BPP {
  BPP_32 = 32
  BPP_16 = 16
}

///|
pub fn ESP_LCD_RGB_QEMU_BPP::to_uint(self : ESP_LCD_RGB_QEMU_BPP) -> UInt = "%identity"

// qemu rgb lcd

///|
pub extern "C" fn esp_lcd_new_rgb_qemu(
  width : Int,
  height : Int,
  bpp : ESP_LCD_RGB_QEMU_BPP
) -> @lcd.Panel = "__wrap_esp_lcd_new_rgb_qemu"

///|
pub extern "C" fn esp_lcd_rgb_qemu_refresh(panel : @lcd.Panel) -> Int = "__wrap_esp_lcd_rgb_qemu_refresh"
