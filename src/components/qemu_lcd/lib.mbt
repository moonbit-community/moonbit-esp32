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
