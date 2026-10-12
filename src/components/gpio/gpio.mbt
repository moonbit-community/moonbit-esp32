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
pub fn GPIOMode::to_int(self : GPIOMode) -> Int32 {
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
pub fn GPIOPullup::to_int(self : GPIOPullup) -> Int32 = "%identity"

///|
pub(all) enum GPIOPulldown {
  GPIO_PULLDOWN_DISABLE = 0
  GPIO_PULLDOWN_ENABLE
}

///|
pub fn GPIOPulldown::to_int(self : GPIOPulldown) -> Int32 = "%identity"

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
pub fn GPIOIntrType::to_int(self : GPIOIntrType) -> Int32 = "%identity"

///|
pub(all) enum GPIOPullMode {
  GPIO_PULLUP_ONLY = 0
  GPIO_PULLDOWN_ONLY
  GPIO_PULLUP_PULLDOWN
  GPIO_FLOATING
}

///|
pub fn GPIOPullMode::to_int(self : GPIOPullMode) -> Int32 = "%identity"

///|
pub(all) enum GPIODriveCap {
  GPIO_DRIVE_CAP_0 = 0
  GPIO_DRIVE_CAP_1
  GPIO_DRIVE_CAP_2
  GPIO_DRIVE_CAP_DEFAULT
  GPIO_DRIVE_CAP_3
  GPIO_DRIVE_CAP_MAX
}

///|
pub fn GPIODriveCap::to_int(self : GPIODriveCap) -> Int32 = "%identity"

///|
pub fn GPIODriveCap::from_int(value : Int32) -> GPIODriveCap = "%identity"

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
  mode~ : Int32,
  pull_up_en~ : Int32,
  pull_down_en~ : Int32,
  intr_type~ : Int32,
) -> Int32 = "__wrap_gpio_config"

///|
pub fn gpio_config(
  pin_bit_mask~ : UInt64,
  mode~ : GPIOMode,
  pull_up_en~ : GPIOPullup,
  pull_down_en~ : GPIOPulldown,
  intr_type~ : GPIOIntrType,
) -> Unit raise @error.ESPError {
  @error.esp_err_wrapper(fn() {
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
extern "C" fn _gpio_reset_pin(gpio_num : Int32) -> Int32 = "gpio_reset_pin"

///|
pub fn gpio_reset_pin(gpio_num : Int32) -> Unit raise @error.ESPError {
  @error.esp_err_wrapper(fn() { _gpio_reset_pin(gpio_num) })
}

///|
extern "C" fn _gpio_set_intr_type(gpio_num : Int32, intr_type : Int32) -> Int32 = "gpio_set_intr_type"

///|
pub fn gpio_set_intr_type(
  gpio_num : Int32,
  intr_type : GPIOIntrType,
) -> Unit raise @error.ESPError {
  @error.esp_err_wrapper(fn() {
    _gpio_set_intr_type(gpio_num, intr_type.to_int())
  })
}

///|
extern "C" fn _gpio_intr_enable(gpio_num : Int32) -> Int32 = "gpio_intr_enable"

///|
pub fn gpio_intr_enable(gpio_num : Int32) -> Unit raise @error.ESPError {
  @error.esp_err_wrapper(fn() { _gpio_intr_enable(gpio_num) })
}

///|
extern "C" fn _gpio_intr_disable(gpio_num : Int32) -> Int32 = "gpio_intr_disable"

///|
pub fn gpio_intr_disable(gpio_num : Int32) -> Unit raise @error.ESPError {
  @error.esp_err_wrapper(fn() { _gpio_intr_disable(gpio_num) })
}

///|
extern "C" fn _gpio_set_level(pin : Int32, level : Int32) -> Int32 = "__wrap_gpio_set_level"

///|
pub fn gpio_set_level(pin : Int32, level : Int32) -> Unit raise @error.ESPError {
  @error.esp_err_wrapper(fn() { _gpio_set_level(pin, level) })
}

///|
extern "C" fn _gpio_get_level(gpio_num : Int32) -> Int32 = "gpio_get_level"

///|
pub fn gpio_get_level(gpio_num : Int32) -> Unit raise @error.ESPError {
  @error.esp_err_wrapper(fn() { _gpio_get_level(gpio_num) })
}

///|
extern "C" fn _gpio_set_direction(gpio_num : Int32, mode : Int32) -> Int32 = "gpio_set_direction"

///|
pub fn gpio_set_direction(
  gpio_num : Int32,
  mode : GPIOMode,
) -> Unit raise @error.ESPError {
  @error.esp_err_wrapper(fn() { _gpio_set_direction(gpio_num, mode.to_int()) })
}

///|
extern "C" fn _gpio_input_enable(gpio_num : Int32) -> Int32 = "gpio_input_enable"

///|
pub fn gpio_input_enable(gpio_num : Int32) -> Unit raise @error.ESPError {
  @error.esp_err_wrapper(fn() { _gpio_input_enable(gpio_num) })
}

///|
extern "C" fn _gpio_set_pull_mode(gpio_num : Int32, pull : Int32) -> Int32 = "gpio_set_pull_mode"

///|
pub fn gpio_set_pull_mode(
  gpio_num : Int32,
  pull : GPIOPullMode,
) -> Unit raise @error.ESPError {
  @error.esp_err_wrapper(fn() { _gpio_set_pull_mode(gpio_num, pull.to_int()) })
}

///|
extern "C" fn _gpio_wakeup_enable(gpio_num : Int32, intr_type : Int32) -> Int32 = "gpio_wakeup_enable"

///|
pub fn gpio_wakeup_enable(
  gpio_num : Int32,
  intr_type : GPIOIntrType,
) -> Unit raise @error.ESPError {
  @error.esp_err_wrapper(fn() {
    _gpio_wakeup_enable(gpio_num, intr_type.to_int())
  })
}

///|
extern "C" fn _gpio_wakeup_disable(gpio_num : Int32) -> Int32 = "gpio_wakeup_disable"

///|
pub fn gpio_wakeup_disable(gpio_num : Int32) -> Unit raise @error.ESPError {
  @error.esp_err_wrapper(fn() { _gpio_wakeup_disable(gpio_num) })
}

///|
extern "C" fn _gpio_isr_register(
  callback : FuncRef[(() -> Unit) -> Unit],
  closure : () -> Unit,
  intr_alloc_flags : Int32,
  handle : @intr.IntrHandle,
) -> Int32 = "gpio_isr_register"

///|
pub fn gpio_isr_register(
  callback : FuncRef[(() -> Unit) -> Unit],
  closure : () -> Unit,
  intr_alloc_flags : Int32,
  handle : @intr.IntrHandle,
) -> Unit raise @error.ESPError {
  @error.esp_err_wrapper(fn() {
    _gpio_isr_register(callback, closure, intr_alloc_flags, handle)
  })
}

///|
extern "C" fn _gpio_pullup_en(gpio_num : Int32) -> Int32 = "gpio_pullup_en"

///|
pub fn gpio_pullup_en(gpio_num : Int32) -> Unit raise @error.ESPError {
  @error.esp_err_wrapper(fn() { _gpio_pullup_en(gpio_num) })
}

///|
extern "C" fn _gpio_pullup_dis(gpio_num : Int32) -> Int32 = "gpio_pullup_dis"

///|
pub fn gpio_pullup_dis(gpio_num : Int32) -> Unit raise @error.ESPError {
  @error.esp_err_wrapper(fn() { _gpio_pullup_dis(gpio_num) })
}

///|
extern "C" fn _gpio_pulldown_en(gpio_num : Int32) -> Int32 = "gpio_pulldown_en"

///|
pub fn gpio_pulldown_en(gpio_num : Int32) -> Unit raise @error.ESPError {
  @error.esp_err_wrapper(fn() { _gpio_pulldown_en(gpio_num) })
}

///|
extern "C" fn _gpio_pulldown_dis(gpio_num : Int32) -> Int32 = "gpio_pulldown_dis"

///|
pub fn gpio_pulldown_dis(gpio_num : Int32) -> Unit raise @error.ESPError {
  @error.esp_err_wrapper(fn() { _gpio_pulldown_dis(gpio_num) })
}

///|
extern "C" fn _gpio_install_isr_service(intr_alloc_flags : Int32) -> Int32 = "gpio_install_isr_service"

///|
pub fn gpio_install_isr_service(
  intr_alloc_flags : Int32,
) -> Unit raise @error.ESPError {
  @error.esp_err_wrapper(fn() { _gpio_install_isr_service(intr_alloc_flags) })
}

///|
extern "C" fn _gpio_uninstall_isr_service() = "gpio_uninstall_isr_service"

///|
pub fn gpio_uninstall_isr_service() -> Unit {
  _gpio_uninstall_isr_service()
}

///|
extern "C" fn _gpio_isr_handler_add(
  gpio_num : Int32,
  isr_handler : FuncRef[(() -> Unit) -> Unit],
  args : () -> Unit,
) -> Int32 = "gpio_isr_handler_add"

///|
pub fn gpio_isr_handler_add(
  gpio_num : Int32,
  isr_handler : FuncRef[(() -> Unit) -> Unit],
  args : () -> Unit,
) -> Unit raise @error.ESPError {
  @error.esp_err_wrapper(fn() {
    _gpio_isr_handler_add(gpio_num, isr_handler, args)
  })
}

///|
extern "C" fn _gpio_isr_handler_remove(gpio_num : Int32) -> Int32 = "gpio_isr_handler_remove"

///|
pub fn gpio_isr_handler_remove(gpio_num : Int32) -> Unit raise @error.ESPError {
  @error.esp_err_wrapper(fn() { _gpio_isr_handler_remove(gpio_num) })
}

///|
extern "C" fn _gpio_set_drive_capability(
  gpio_num : Int32,
  strength : Int32,
) -> Int32 = "gpio_set_drive_capability"

///|
pub fn gpio_set_drive_capability(
  gpio_num : Int32,
  strength : GPIODriveCap,
) -> Unit raise @error.ESPError {
  @error.esp_err_wrapper(fn() {
    _gpio_set_drive_capability(gpio_num, strength.to_int())
  })
}

///|
#owned(strength)
extern "C" fn _gpio_get_drive_capability(
  gpio_num : Int32,
  strength : Ref[Int32],
) -> Int32 = "gpio_get_drive_capability"

///|
pub fn gpio_get_drive_capability(
  gpio_num : Int32,
  strength : Ref[GPIODriveCap],
) -> Unit raise @error.ESPError {
  @error.esp_err_wrapper(fn() {
    let tmp = @ref.Ref(0)
    let ret = _gpio_get_drive_capability(gpio_num, tmp)
    strength.val = GPIODriveCap::from_int(tmp.val)
    ret
  })
}

///|
extern "C" fn _gpio_hold_en(gpio_num : Int32) -> Int32 = "gpio_hold_en"

///|
pub fn gpio_hold_en(gpio_num : Int32) -> Unit raise @error.ESPError {
  @error.esp_err_wrapper(fn() { _gpio_hold_en(gpio_num) })
}

///|
extern "C" fn _gpio_hold_dis(gpio_num : Int32) -> Int32 = "gpio_hold_dis"

///|
pub fn gpio_hold_dis(gpio_num : Int32) -> Unit raise @error.ESPError {
  @error.esp_err_wrapper(fn() { _gpio_hold_dis(gpio_num) })
}

///|
extern "C" fn _gpio_deep_sleep_hold_en() = "gpio_deep_sleep_hold_en"

///|
pub fn gpio_deep_sleep_hold_en() -> Unit {
  _gpio_deep_sleep_hold_en()
}

///|
extern "C" fn _gpio_deep_sleep_hold_dis() = "gpio_deep_sleep_hold_dis"

///|
pub fn gpio_deep_sleep_hold_dis() -> Unit {
  _gpio_deep_sleep_hold_dis()
}

///|
extern "C" fn _gpio_iomux_in(gpio_num : UInt32, signal_idx : UInt32) = "gpio_iomux_in"

///|
pub fn gpio_iomux_in(gpio_num : UInt32, signal_idx : UInt32) -> Unit {
  _gpio_iomux_in(gpio_num, signal_idx)
}

///|
extern "C" fn _gpio_iomux_out(gpio_num : Byte, func : Int32, out_en_inv : Bool) = "gpio_iomux_out"

///|
pub fn gpio_iomux_out(gpio_num : Byte, func : Int32, out_en_inv : Bool) -> Unit {
  _gpio_iomux_out(gpio_num, func, out_en_inv)
}

///|
extern "C" fn _gpio_force_hold_all() -> Int32 = "gpio_force_hold_all"

///|
pub fn gpio_force_hold_all() -> Unit raise @error.ESPError {
  @error.esp_err_wrapper(fn() { _gpio_force_hold_all() })
}

///|
extern "C" fn _gpio_force_unhold_all() -> Int32 = "gpio_force_unhold_all"

///|
pub fn gpio_force_unhold_all() -> Unit raise @error.ESPError {
  @error.esp_err_wrapper(fn() { _gpio_force_unhold_all() })
}

///|
extern "C" fn _gpio_sleep_sel_en(gpio_num : Int32) -> Int32 = "gpio_sleep_sel_en"

///|
pub fn gpio_sleep_sel_en(gpio_num : Int32) -> Unit raise @error.ESPError {
  @error.esp_err_wrapper(fn() { _gpio_sleep_sel_en(gpio_num) })
}

///|
extern "C" fn _gpio_sleep_sel_dis(gpio_num : Int32) -> Int32 = "gpio_sleep_sel_dis"

///|
pub fn gpio_sleep_sel_dis(gpio_num : Int32) -> Unit raise @error.ESPError {
  @error.esp_err_wrapper(fn() { _gpio_sleep_sel_dis(gpio_num) })
}

///|
extern "C" fn _gpio_sleep_set_direction(
  gpio_num : Int32,
  mode : Int32,
) -> Int32 = "gpio_sleep_set_direction"

///|
pub fn gpio_sleep_set_direction(
  gpio_num : Int32,
  mode : GPIOMode,
) -> Unit raise @error.ESPError {
  @error.esp_err_wrapper(fn() {
    _gpio_sleep_set_direction(gpio_num, mode.to_int())
  })
}

///|
extern "C" fn _gpio_sleep_set_pull_mode(
  gpio_num : Int32,
  pull : Int32,
) -> Int32 = "gpio_sleep_set_pull_mode"

///|
pub fn gpio_sleep_set_pull_mode(
  gpio_num : Int32,
  pull : GPIOPullMode,
) -> Unit raise @error.ESPError {
  @error.esp_err_wrapper(fn() {
    _gpio_sleep_set_pull_mode(gpio_num, pull.to_int())
  })
}

///|
extern "C" fn _gpio_deep_sleep_wakeup_enable(
  gpio_num : Int32,
  intr_type : Int32,
) -> Int32 = "gpio_deep_sleep_wakeup_enable"

///|
pub fn gpio_deep_sleep_wakeup_enable(
  gpio_num : Int32,
  intr_type : GPIOIntrType,
) -> Unit raise @error.ESPError {
  @error.esp_err_wrapper(fn() {
    _gpio_deep_sleep_wakeup_enable(gpio_num, intr_type.to_int())
  })
}

///|
extern "C" fn _gpio_deep_sleep_wakeup_disable(gpio_num : Int32) -> Int32 = "gpio_deep_sleep_wakeup_disable"

///|
pub fn gpio_deep_sleep_wakeup_disable(
  gpio_num : Int32,
) -> Unit raise @error.ESPError {
  @error.esp_err_wrapper(fn() { _gpio_deep_sleep_wakeup_disable(gpio_num) })
}

// TODO
//esp_err_t gpio_dump_io_configuration(FILE *out_stream, uint64_t io_bit_mask)
