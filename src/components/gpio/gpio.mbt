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
  GPIO_PULLDOWN_ENABLE = 1
}

///|
pub fn GPIOPulldown::to_int(self : GPIOPulldown) -> Int = "%identity"

///|
pub(all) enum GPIOIntType {
  GPIO_INTR_DISABLE = 0
  GPIO_INTR_POSEDGE = 1
  GPIO_INTR_NEGEDGE = 2
  GPIO_INTR_ANYEDGE = 3
  GPIO_INTR_LOW_LEVEL = 4
  GPIO_INTR_HIGH_LEVEL = 5
  GPIO_INTR_MAX = 6
}

///|
pub fn GPIOIntType::to_int(self : GPIOIntType) -> Int = "%identity"

///|
pub(all) struct GPIOConfig {
  pin_bit_mask : UInt64
  mode : GPIOMode
  pull_up_en : GPIOPullup
  pull_down_en : GPIOPulldown
  intr_type : GPIOIntType
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
  intr_type~ : GPIOIntType
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
extern "C" fn _gpio_set_level(pin : Int, level : Int) -> Int = "__wrap_gpio_set_level"

///|
pub fn gpio_set_level(pin : Int, level : Int) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() { _gpio_set_level(pin, level) })
}
