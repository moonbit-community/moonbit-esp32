/*
 * // Copyright 2025 International Digital Economy Academy
 * //
 * // Licensed under the Apache License, Version 2.0 (the "License");
 * // you may not use this file except in compliance with the License.
 * // You may obtain a copy of the License at
 * //
 * //     http://www.apache.org/licenses/LICENSE-2.0
 * //
 * // Unless required by applicable law or agreed to in writing, software
 * // distributed under the License is distributed on an "AS IS" BASIS,
 * // WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * // See the License for the specific language governing permissions and
 * // limitations under the License.
 */

#include "driver/ledc.h"

int __wrap_ledc_channel_config(int gpio_num, int speed_mod, int channel,
                               int intr_type, int timer_sel, unsigned int duty,
                               int hpoint, int sleep_mode, int flags) {
  ledc_channel_config_t ledc_channel = {
      .gpio_num = gpio_num,
      .speed_mode = (ledc_mode_t)speed_mod,
      .channel = (ledc_channel_t)channel,
      .intr_type = (ledc_intr_type_t)intr_type,
      .timer_sel = (ledc_timer_t)timer_sel,
      .duty = duty,
      .hpoint = hpoint,
      .flags = (ledc_channel_flags_t)flags,
  };
  return ledc_channel_config(&ledc_channel);
}

/*

extern "C" fn _ledc_timer_config(
  speed_mode~ : Int,
  duty_resolution~ : Int,
  timer_num~ : Int,
  freq_hz~ : UInt,
  clk_cfg~ : Int,
  deconfigure~ : Bool
) -> Int = "__wrap_ledc_timer_config"

*/

int __wrap_ledc_timer_config(int speed_mod, int timer_sel, int duty_resolution,
                             int timer_num, int freq_hz, int clk_cfg,
                             bool deconfigure) {
  ledc_timer_config_t ledc_timer = {
      .speed_mode = (ledc_mode_t)speed_mod,
      .timer_num = (ledc_timer_t)timer_sel,
      .duty_resolution = (ledc_timer_bit_t)duty_resolution,
      .freq_hz = freq_hz,
      .clk_cfg = (ledc_clk_cfg_t)clk_cfg,
      .deconfigure = deconfigure,
  };
  return ledc_timer_config(&ledc_timer);
}
