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
pub(all) enum LEDCMode {
  LEDC_LOW_SPEED_MODE = 0
  LEDC_LOW_SPEED_MODE_MAX
}

///|
pub fn LEDCMode::to_int(self : LEDCMode) -> Int = "%identity"

///|
pub(all) enum LEDCIntrType {
  LEDC_INTR_DISABLE = 0
  LEDC_INTR_FADE_END
  LEDC_INTR_MAX
}

///|
pub fn LEDCIntrType::to_int(self : LEDCIntrType) -> Int = "%identity"

///|
pub(all) enum LEDCDutyDirection {
  LEDC_DUTY_DIR_DECREASE = 0
  LEDC_DUTY_DIR_INCREASE
  LEDC_DUTY_DIR_MAX
}

///|
pub fn LEDCDutyDirection::to_int(self : LEDCDutyDirection) -> Int = "%identity"

///|
pub(all) enum LEDCChannel {
  LEDC_CHANNEL_0 = 0
  LEDC_CHANNEL_1
  LEDC_CHANNEL_2
  LEDC_CHANNEL_3
  LEDC_CHANNEL_4
  LEDC_CHANNEL_5
}

///|
pub fn LEDCChannel::to_int(self : LEDCChannel) -> Int = "%identity"

///|
pub(all) enum LEDCTimer {
  LEDC_TIMER_0 = 0
  LEDC_TIMER_1
  LEDC_TIMER_2
  LEDC_TIMER_3
}

///|
pub fn LEDCTimer::to_int(self : LEDCTimer) -> Int = "%identity"

///|
pub(all) enum LEDCSleepMode {
  LEDC_SLEEP_MODE_NO_ALIVE_NO_PD = 0
  LEDC_SLEEP_MODE_NO_ALIVE_ALLOW_PD
  LEDC_SLEEP_MODE_KEEP_ALIVE
  LEDC_SLEEP_MODE_INVALID
}

///|
pub fn LEDCSleepMode::to_int(self : LEDCSleepMode) -> Int = "%identity"

///|
pub(all) enum LEDCTimerBit {
  LEDC_TIMER_1_BIT = 1
  LEDC_TIMER_2_BIT
  LEDC_TIMER_3_BIT
  LEDC_TIMER_4_BIT
  LEDC_TIMER_5_BIT
  LEDC_TIMER_6_BIT
  LEDC_TIMER_7_BIT
  LEDC_TIMER_8_BIT
  LEDC_TIMER_9_BIT
  LEDC_TIMER_10_BIT
  LEDC_TIMER_11_BIT
  LEDC_TIMER_12_BIT
  LEDC_TIMER_13_BIT
  LEDC_TIMER_14_BIT
}

///|
pub fn LEDCTimerBit::to_int(self : LEDCTimerBit) -> Int = "%identity"

///|
pub(all) enum LEDCClkCfg {
  LEDC_AUTO_CLK = 0
  LEDC_USE_APB_CLK = 4
  LEDC_USE_RC_FAST_CLK = 8
  LEDC_USE_XTAL_CLK = 10
}

///|
pub fn LEDCClkCfg::to_int(self : LEDCClkCfg) -> Int = "%identity"

///|
pub(all) enum LEDCFadeMode {
  LEDC_FADE_NO_WAIT = 0
  LEDC_FADE_WAIT_DONE
}

///|
pub fn LEDCFadeMode::to_int(self : LEDCFadeMode) -> Int = "%identity"

///|
extern "C" fn _ledc_channel_config(
  gpio_num~ : Int,
  speed_mod~ : Int,
  channel~ : Int,
  intr_type~ : Int,
  timer_sel~ : Int,
  duty~ : UInt,
  hpoint~ : Int,
  sleep_mode~ : Int,
  flags~ : Int
) -> Int = "__wrap_ledc_channel_config"

///|
pub fn ledc_channel_config(
  gpio_num~ : Int,
  speed_mod~ : LEDCMode = LEDCMode::LEDC_LOW_SPEED_MODE,
  channel~ : LEDCChannel,
  intr_type~ : LEDCIntrType,
  timer_sel~ : LEDCTimer = LEDCTimer::LEDC_TIMER_0,
  duty~ : UInt = 0,
  hpoint~ : Int = 0,
  sleep_mode~ : LEDCSleepMode = LEDCSleepMode::LEDC_SLEEP_MODE_NO_ALIVE_NO_PD,
  flags~ : Int = 0
) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() {
    _ledc_channel_config(
      gpio_num~,
      speed_mod=speed_mod.to_int(),
      channel=channel.to_int(),
      intr_type=intr_type.to_int(),
      timer_sel=timer_sel.to_int(),
      duty~,
      hpoint~,
      sleep_mode=sleep_mode.to_int(),
      flags~,
    )
  })
}

///|
pub extern "C" fn ledc_find_suitable_duty_resolution(
  src_clk_freq : UInt,
  timer_freq : UInt
) -> UInt = "ledc_find_suitable_duty_resolution"

///|
extern "C" fn _ledc_timer_config(
  speed_mode~ : Int,
  duty_resolution~ : Int,
  timer_num~ : Int,
  freq_hz~ : UInt,
  clk_cfg~ : Int,
  deconfigure~ : Bool
) -> Int = "__wrap_ledc_timer_config"

///|
pub fn ledc_timer_config(
  speed_mode~ : LEDCMode,
  duty_resolution~ : LEDCTimerBit,
  timer_num~ : LEDCTimer,
  freq_hz~ : UInt,
  clk_cfg~ : LEDCClkCfg = LEDCClkCfg::LEDC_AUTO_CLK,
  deconfigure~ : Bool = false
) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() {
    _ledc_timer_config(
      speed_mode=speed_mode.to_int(),
      duty_resolution=duty_resolution.to_int(),
      timer_num=timer_num.to_int(),
      freq_hz~,
      clk_cfg=clk_cfg.to_int(),
      deconfigure~,
    )
  })
}

///|
extern "C" fn _ledc_update_duty(speed_mode : Int, channel : Int) -> Int = "ledc_update_duty"

///|
pub fn ledc_update_duty(
  speed_mode : LEDCMode,
  channel : LEDCChannel
) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() {
    _ledc_update_duty(speed_mode.to_int(), channel.to_int())
  })
}

///|
extern "C" fn _ledc_set_pin(
  gpio_num : Int,
  speed_mode : Int,
  channel : Int
) -> Int = "ledc_set_pin"

///|
pub fn ledc_set_pin(
  gpio_num : Int,
  speed_mode : LEDCMode,
  channel : LEDCChannel
) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() {
    _ledc_set_pin(gpio_num, speed_mode.to_int(), channel.to_int())
  })
}

///|
extern "C" fn _ledc_stop(
  speed_mode : Int,
  channel : Int,
  idle_level : UInt
) -> Int = "ledc_stop"

///|
pub fn ledc_stop(
  speed_mode : LEDCMode,
  channel : LEDCChannel,
  idle_level : UInt
) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() {
    _ledc_stop(speed_mode.to_int(), channel.to_int(), idle_level)
  })
}

///|
extern "C" fn _ledc_set_freq(
  speed_mode : Int,
  timer_num : Int,
  freq_hz : UInt
) -> Int = "ledc_set_freq"

///|
pub fn ledc_set_freq(
  speed_mode : LEDCMode,
  timer_num : LEDCTimer,
  freq_hz : UInt
) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() {
    _ledc_set_freq(speed_mode.to_int(), timer_num.to_int(), freq_hz)
  })
}

///|
extern "C" fn _ledc_get_freq(speed_mode : Int, timer_num : Int) -> UInt = "ledc_get_freq"

///|
pub fn ledc_get_freq(speed_mode : LEDCMode, timer_num : LEDCTimer) -> UInt {
  _ledc_get_freq(speed_mode.to_int(), timer_num.to_int())
}

///|
extern "C" fn _ledc_set_duty_with_hpoint(
  speed_mode : Int,
  channel : Int,
  duty : UInt,
  hpoint : UInt
) -> Int = "ledc_set_duty_with_hpoint"

///|
pub fn ledc_set_duty_with_hpoint(
  speed_mode : LEDCMode,
  channel : LEDCChannel,
  duty : UInt,
  hpoint : UInt
) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() {
    _ledc_set_duty_with_hpoint(
      speed_mode.to_int(),
      channel.to_int(),
      duty,
      hpoint,
    )
  })
}

///|
extern "C" fn _ledc_get_hpoint(speed_mode : Int, channel : Int) -> Int = "ledc_get_hpoint"

///|
pub fn ledc_get_hpoint(speed_mode : LEDCMode, channel : LEDCChannel) -> Int {
  _ledc_get_hpoint(speed_mode.to_int(), channel.to_int())
}

///|
extern "C" fn _ledc_set_duty(
  speed_mode : Int,
  channel : Int,
  duty : UInt
) -> Int = "ledc_set_duty"

///|
pub fn ledc_set_duty(
  speed_mode : LEDCMode,
  channel : LEDCChannel,
  duty : UInt
) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() {
    _ledc_set_duty(speed_mode.to_int(), channel.to_int(), duty)
  })
}

///|
extern "C" fn _ledc_get_duty(speed_mode : Int, channel : Int) -> UInt = "ledc_get_duty"

///|
pub fn ledc_get_duty(speed_mode : LEDCMode, channel : LEDCChannel) -> UInt {
  _ledc_get_duty(speed_mode.to_int(), channel.to_int())
}

///|
extern "C" fn _ledc_set_fade(
  speed_mode : Int,
  channel : Int,
  duty : UInt,
  fade_direction : Int,
  step_num : UInt,
  duty_cycle_num : UInt,
  duty_scale : UInt
) -> Int = "ledc_set_fade"

///|
pub fn ledc_set_fade(
  speed_mode : LEDCMode,
  channel : LEDCChannel,
  duty : UInt,
  fade_direction : LEDCDutyDirection,
  step_num : UInt,
  duty_cycle_num : UInt,
  duty_scale : UInt
) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() {
    _ledc_set_fade(
      speed_mode.to_int(),
      channel.to_int(),
      duty,
      fade_direction.to_int(),
      step_num,
      duty_cycle_num,
      duty_scale,
    )
  })
}

///|
extern "C" fn _ledc_isr_register(
  callback : FuncRef[(() -> Unit) -> Unit],
  closure : () -> Unit,
  intr_alloc_flags : Int,
  handle : @intr.IntrHandle
) -> Int = "ledc_isr_register"

///|
pub fn ledc_isr_register(
  callback : FuncRef[(() -> Unit) -> Unit],
  closure : () -> Unit,
  intr_alloc_flags : Int,
  handle : @intr.IntrHandle
) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() {
    _ledc_isr_register(callback, closure, intr_alloc_flags, handle)
  })
}

///|
extern "C" fn _ledc_timer_set(
  speed_mode : Int,
  timer_sel : Int,
  clock_divider : UInt,
  duty_resolution : UInt,
  clk_src : Int
) -> Int = "ledc_timer_set"

///|
pub fn ledc_timer_set(
  speed_mode : LEDCMode,
  timer_sel : LEDCTimer,
  clock_divider : UInt,
  duty_resolution : UInt,
  clk_src : LEDCClkCfg
) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() {
    _ledc_timer_set(
      speed_mode.to_int(),
      timer_sel.to_int(),
      clock_divider,
      duty_resolution,
      clk_src.to_int(),
    )
  })
}

///|
extern "C" fn _ledc_timer_rst(speed_mode : Int, timer_sel : Int) -> Int = "ledc_timer_rst"

///|
pub fn ledc_timer_rst(
  speed_mode : LEDCMode,
  timer_sel : LEDCTimer
) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() {
    _ledc_timer_rst(speed_mode.to_int(), timer_sel.to_int())
  })
}

///|
extern "C" fn _ledc_timer_pause(speed_mode : Int, timer_sel : Int) -> Int = "ledc_timer_pause"

///|
pub fn ledc_timer_pause(
  speed_mode : LEDCMode,
  timer_sel : LEDCTimer
) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() {
    _ledc_timer_pause(speed_mode.to_int(), timer_sel.to_int())
  })
}

///|
extern "C" fn _ledc_timer_resume(speed_mode : Int, timer_sel : Int) -> Int = "ledc_timer_resume"

///|
pub fn ledc_timer_resume(
  speed_mode : LEDCMode,
  timer_sel : LEDCTimer
) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() {
    _ledc_timer_resume(speed_mode.to_int(), timer_sel.to_int())
  })
}

///|
extern "C" fn _ledc_bind_channel_timer(
  speed_mode : Int,
  channel : Int,
  timer_sel : Int
) -> Int = "ledc_bind_channel_timer"

///|
pub fn ledc_bind_channel_timer(
  speed_mode : LEDCMode,
  channel : LEDCChannel,
  timer_sel : LEDCTimer
) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() {
    _ledc_bind_channel_timer(
      speed_mode.to_int(),
      channel.to_int(),
      timer_sel.to_int(),
    )
  })
}

///|
extern "C" fn _ledc_set_fade_with_step(
  speed_mode : Int,
  channel : Int,
  target_duty : UInt,
  scale : UInt,
  cycle_num : UInt
) -> Int = "ledc_set_fade_with_step"

///|
pub fn ledc_set_fade_with_step(
  speed_mode : LEDCMode,
  channel : LEDCChannel,
  target_duty : UInt,
  scale : UInt,
  cycle_num : UInt
) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() {
    _ledc_set_fade_with_step(
      speed_mode.to_int(),
      channel.to_int(),
      target_duty,
      scale,
      cycle_num,
    )
  })
}

///|
extern "C" fn _ledc_set_fade_with_time(
  speed_mode : Int,
  channel : Int,
  target_duty : UInt,
  max_fade_time_ms : Int
) -> Int = "ledc_set_fade_with_time"

///|
pub fn ledc_set_fade_with_time(
  speed_mode : LEDCMode,
  channel : LEDCChannel,
  target_duty : UInt,
  max_fade_time_ms : Int
) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() {
    _ledc_set_fade_with_time(
      speed_mode.to_int(),
      channel.to_int(),
      target_duty,
      max_fade_time_ms,
    )
  })
}

///|
extern "C" fn _ledc_fade_func_install(intr_alloc_flags : Int) -> Int = "ledc_fade_func_install"

///|
pub fn ledc_fade_func_install(intr_alloc_flags : Int) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() { _ledc_fade_func_install(intr_alloc_flags) })
}

///|
extern "C" fn _ledc_fade_func_uninstall() = "ledc_fade_func_uninstall"

///|
pub fn ledc_fade_func_uninstall() -> Unit {
  _ledc_fade_func_uninstall()
}

///|
extern "C" fn _ledc_fade_start(
  speed_mode : Int,
  channel : Int,
  fade_mode : Int
) -> Int = "ledc_fade_start"

///|
pub fn ledc_fade_start(
  speed_mode : LEDCMode,
  channel : LEDCChannel,
  fade_mode : LEDCFadeMode
) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() {
    _ledc_fade_start(speed_mode.to_int(), channel.to_int(), fade_mode.to_int())
  })
}

///|
extern "C" fn _ledc_fade_stop(speed_mode : Int, channel : Int) -> Int = "ledc_fade_stop"

///|
pub fn ledc_fade_stop(
  speed_mode : LEDCMode,
  channel : LEDCChannel
) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() {
    _ledc_fade_stop(speed_mode.to_int(), channel.to_int())
  })
}

///|
extern "C" fn _ledc_set_duty_and_update(
  speed_mode : Int,
  channel : Int,
  duty : UInt,
  hpoint : UInt
) -> Int = "ledc_set_duty_and_update"

///|
pub fn ledc_set_duty_and_update(
  speed_mode : LEDCMode,
  channel : LEDCChannel,
  duty : UInt,
  hpoint : UInt
) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() {
    _ledc_set_duty_and_update(
      speed_mode.to_int(),
      channel.to_int(),
      duty,
      hpoint,
    )
  })
}

///|
extern "C" fn _ledc_set_fade_time_and_start(
  speed_mode : Int,
  channel : Int,
  target_duty : UInt,
  max_fade_time_ms : UInt,
  fade_mode : Int
) -> Int = "ledc_set_fade_time_and_start"

///|
pub fn ledc_set_fade_time_and_start(
  speed_mode : LEDCMode,
  channel : LEDCChannel,
  target_duty : UInt,
  max_fade_time_ms : UInt,
  fade_mode : LEDCFadeMode
) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() {
    _ledc_set_fade_time_and_start(
      speed_mode.to_int(),
      channel.to_int(),
      target_duty,
      max_fade_time_ms,
      fade_mode.to_int(),
    )
  })
}

///|
extern "C" fn _ledc_set_fade_step_and_start(
  speed_mode : Int,
  channel : Int,
  target_duty : UInt,
  scale : UInt,
  cycle_num : UInt,
  fade_mode : Int
) -> Int = "ledc_set_fade_step_and_start"

///|
pub fn ledc_set_fade_step_and_start(
  speed_mode : LEDCMode,
  channel : LEDCChannel,
  target_duty : UInt,
  scale : UInt,
  cycle_num : UInt,
  fade_mode : LEDCFadeMode
) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() {
    _ledc_set_fade_step_and_start(
      speed_mode.to_int(),
      channel.to_int(),
      target_duty,
      scale,
      cycle_num,
      fade_mode.to_int(),
    )
  })
}

// TODO
// esp_err_t ledc_cb_register(ledc_mode_t speed_mode, ledc_channel_t channel, ledc_cbs_t *cbs, void *user_arg)
