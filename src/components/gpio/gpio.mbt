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
pub const GPIO_MODE_DEF_DISABLE = 0

///|
pub const GPIO_MODE_DEF_INPUT = 0x00000001

///|
pub const GPIO_MODE_DEF_OUTPUT = 0x00000002

///|
pub const GPIO_MODE_DEF_OD = 0x00000004

///|
pub(all) enum GPIOMode {
  GPIO_MODE_DISABLE
  GPIO_MODE_INPUT
  GPIO_MODE_OUTPUT
  GPIO_MODE_OUTPUT_OD
  GPIO_MODE_INPUT_OUTPUT_OD
  GPIO_MODE_INPUT_OUTPUT
}

///|
pub fn GPIOMode::to_int(self : GPIOMode) -> Int {
  match self {
    GPIO_MODE_DISABLE => GPIO_MODE_DEF_DISABLE
    GPIO_MODE_INPUT => GPIO_MODE_DEF_INPUT
    GPIO_MODE_OUTPUT => GPIO_MODE_DEF_OUTPUT
    GPIO_MODE_OUTPUT_OD => GPIO_MODE_DEF_OUTPUT | GPIO_MODE_DEF_OD
    GPIO_MODE_INPUT_OUTPUT_OD =>
      GPIO_MODE_DEF_INPUT | GPIO_MODE_DEF_OUTPUT | GPIO_MODE_DEF_OD
    GPIO_MODE_INPUT_OUTPUT => GPIO_MODE_DEF_INPUT | GPIO_MODE_DEF_OUTPUT
  }
}

///|
pub(all) enum GPIOPullup {
  GPIO_PULLUP_DISABLE = 0
  GPIO_PULLUP_ENABLE = 1
}

///|
pub fn GPIOPullup::to_int(self : GPIOPullup) -> Int = "%identity"

///|
pub(all) enum GPIOPulldown {
  GPIO_PULLDOWN_DISABLE = 0
  GPIO_PULLDOWN_ENABLE
}

///|
pub fn GPIOPulldown::to_int(self : GPIOPulldown) -> Int = "%identity"

///|
pub(all) enum GPIOIntrType {
  GPIO_INTR_DISABLE = 0
  GPIO_INTR_POSEDGE
  GPIO_INTR_NEGEDGE
  GPIO_INTR_ANYEDGE
  GPIO_INTR_LOW_LEVEL
  GPIO_INTR_HIGH_LEVEL
  GPIO_INTR_MAX
}

///|
pub fn GPIOIntrType::to_int(self : GPIOIntrType) -> Int = "%identity"

///|
pub(all) enum GPIOPullMode {
  GPIO_PULLUP_ONLY = 0
  GPIO_PULLDOWN_ONLY
  GPIO_PULLUP_PULLDOWN
  GPIO_FLOATING
}

///|
pub fn GPIOPullMode::to_int(self : GPIOPullMode) -> Int = "%identity"

///|
pub(all) struct GPIOConfig {
  pin_bit_mask : UInt64
  mode : GPIOMode
  pull_up_en : GPIOPullup
  pull_down_en : GPIOPulldown
  intr_type : GPIOIntrType
}

///|
extern "C" fn _gpio_config(
  pin_bit_mask~ : UInt64,
  mode~ : Int,
  pull_up_en~ : Int,
  pull_down_en~ : Int,
  intr_type~ : Int
) -> Int = "__wrap_gpio_config"

///|
pub fn gpio_config(
  pin_bit_mask~ : UInt64,
  mode~ : GPIOMode,
  pull_up_en~ : GPIOPullup,
  pull_down_en~ : GPIOPulldown,
  intr_type~ : GPIOIntrType
) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() {
    _gpio_config(
      pin_bit_mask~,
      mode=mode.to_int(),
      pull_up_en=pull_up_en.to_int(),
      pull_down_en=pull_down_en.to_int(),
      intr_type=intr_type.to_int(),
    )
  })
}

///|
extern "C" fn _gpio_reset_pin(gpio_num : Int) -> Int = "gpio_reset_pin"

///|
pub fn gpio_reset_pin(gpio_num : Int) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() { _gpio_reset_pin(gpio_num) })
}

///|
extern "C" fn _gpio_set_intr_type(gpio_num : Int, intr_type : Int) -> Int = "gpio_set_intr_type"

///|
pub fn gpio_set_intr_type(
  gpio_num : Int,
  intr_type : GPIOIntrType
) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() {
    _gpio_set_intr_type(gpio_num, intr_type.to_int())
  })
}

///|
extern "C" fn _gpio_intr_enable(gpio_num : Int) -> Int = "gpio_intr_enable"

///|
pub fn gpio_intr_enable(gpio_num : Int) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() { _gpio_intr_enable(gpio_num) })
}

///|
extern "C" fn _gpio_intr_disable(gpio_num : Int) -> Int = "gpio_intr_disable"

///|
pub fn gpio_intr_disable(gpio_num : Int) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() { _gpio_intr_disable(gpio_num) })
}

///|
extern "C" fn _gpio_set_level(pin : Int, level : Int) -> Int = "__wrap_gpio_set_level"

///|
pub fn gpio_set_level(pin : Int, level : Int) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() { _gpio_set_level(pin, level) })
}

///|
extern "C" fn _gpio_get_level(gpio_num : Int) -> Int = "gpio_get_level"

///|
pub fn gpio_get_level(gpio_num : Int) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() { _gpio_get_level(gpio_num) })
}

///|
extern "C" fn _gpio_set_direction(gpio_num : Int, mode : Int) -> Int = "gpio_set_direction"

///|
pub fn gpio_set_direction(
  gpio_num : Int,
  mode : GPIOMode
) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() { _gpio_set_direction(gpio_num, mode.to_int()) })
}

///|
extern "C" fn _gpio_input_enable(gpio_num : Int) -> Int = "gpio_input_enable"

///|
pub fn gpio_input_enable(gpio_num : Int) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() { _gpio_input_enable(gpio_num) })
}

///|
extern "C" fn _gpio_set_pull_mode(gpio_num : Int, pull : Int) -> Int = "gpio_set_pull_mode"

///|
pub fn gpio_set_pull_mode(
  gpio_num : Int,
  pull : GPIOPullMode
) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() { _gpio_set_pull_mode(gpio_num, pull.to_int()) })
}

///|
extern "C" fn _gpio_wakeup_enable(gpio_num : Int, intr_type : Int) -> Int = "gpio_wakeup_enable"

///|
pub fn gpio_wakeup_enable(
  gpio_num : Int,
  intr_type : GPIOIntrType
) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() {
    _gpio_wakeup_enable(gpio_num, intr_type.to_int())
  })
}

///|
extern "C" fn _gpio_wakeup_disable(gpio_num : Int) -> Int = "gpio_wakeup_disable"

///|
pub fn gpio_wakeup_disable(gpio_num : Int) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() { _gpio_wakeup_disable(gpio_num) })
}

// TODO
// esp_err_t gpio_isr_register(void (*fn)(void*), void *arg, int intr_alloc_flags, gpio_isr_handle_t *handle)

///|
extern "C" fn _gpio_pullup_en(gpio_num : Int) -> Int = "gpio_pullup_en"

///|
pub fn gpio_pullup_en(gpio_num : Int) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() { _gpio_pullup_en(gpio_num) })
}

///|
extern "C" fn _gpio_pullup_dis(gpio_num : Int) -> Int = "gpio_pullup_dis"

///|
pub fn gpio_pullup_dis(gpio_num : Int) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() { _gpio_pullup_dis(gpio_num) })
}

///|
extern "C" fn _gpio_pulldown_en(gpio_num : Int) -> Int = "gpio_pulldown_en"

///|
pub fn gpio_pulldown_en(gpio_num : Int) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() { _gpio_pulldown_en(gpio_num) })
}

///|
extern "C" fn _gpio_pulldown_dis(gpio_num : Int) -> Int = "gpio_pulldown_dis"

///|
pub fn gpio_pulldown_dis(gpio_num : Int) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() { _gpio_pulldown_dis(gpio_num) })
}

///|
extern "C" fn _gpio_install_isr_service(intr_alloc_flags : Int) -> Int = "gpio_install_isr_service"

///|
pub fn gpio_install_isr_service(intr_alloc_flags : Int) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() { _gpio_install_isr_service(intr_alloc_flags) })
}

///|
extern "C" fn _gpio_uninstall_isr_service() = "gpio_uninstall_isr_service"

///|
pub fn gpio_uninstall_isr_service() -> Unit {
  _gpio_uninstall_isr_service()
}
