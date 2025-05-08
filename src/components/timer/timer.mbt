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
extern "C" fn _esp_timer_early_init() -> Int = "esp_timer_early_init"

///|
pub fn esp_timer_early_init() -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() { _esp_timer_early_init() })
}

///|
extern "C" fn _esp_timer_init() -> Int = "esp_timer_init"

///|
pub fn esp_timer_init() -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() { _esp_timer_init() })
}

///|
extern "C" fn _esp_timer_deinit() -> Int = "esp_timer_deinit"

///|
pub fn esp_timer_deinit() -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() { _esp_timer_deinit() })
}

///|
extern type ESPTimer

///|
pub extern "C" fn esp_timer_create(callback : FuncRef[() -> Unit]) -> ESPTimer = "__wrap_esp_timer_create"

///|
pub extern "C" fn esp_timer_start_once(
  timer : ESPTimer,
  timeout_us : Int64
) -> Int = "__wrap_esp_timer_start_once"

///|
pub extern "C" fn esp_timer_start_periodic(
  timer : ESPTimer,
  timeout_us : Int64
) -> Int = "esp_timer_start_periodic"

///|
pub extern "C" fn esp_timer_restart(
  timer : ESPTimer,
  timeout_us : Int64
) -> Int = "esp_timer_restart"

///|
extern "C" fn _esp_timer_stop(timer : ESPTimer) -> Int = "esp_timer_stop"

///|
pub fn esp_timer_stop(timer : ESPTimer) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() { _esp_timer_stop(timer) })
}

///|
extern "C" fn _esp_timer_delete(timer : ESPTimer) -> Int = "esp_timer_delete"

///|
pub fn esp_timer_delete(timer : ESPTimer) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() { _esp_timer_delete(timer) })
}

///|
pub extern "C" fn esp_timer_get_time() -> Int64 = "esp_timer_get_time"

///|
pub extern "C" fn esp_timer_get_next_alarm() -> Int64 = "esp_timer_get_next_alarm"

///|
pub extern "C" fn esp_timer_get_next_alarm_for_wake_up() -> Int64 = "esp_timer_get_next_alarm_for_wake_up"

///|
extern "C" fn _esp_timer_get_period(
  timer : ESPTimer,
  period : Ref[UInt64]
) -> Int = "__wrap_esp_timer_get_period"

///|
pub fn esp_timer_get_period(
  timer : ESPTimer,
  period : Ref[UInt64]
) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() { _esp_timer_get_period(timer, period) })
}

///|
extern "C" fn _esp_timer_get_expiry_time(
  timer : ESPTimer,
  expiry : Ref[UInt64]
) -> Int = "__wrap_esp_timer_get_expiry_time"

///|
pub fn esp_timer_get_expiry_time(
  timer : ESPTimer,
  expiry : Ref[UInt64]
) -> Unit!@error.ESPError {
  @error.esp_err_wrapper!(fn() { _esp_timer_get_expiry_time(timer, expiry) })
}

// TODO
// esp_err_t esp_timer_dump(FILE *stream)

///|
pub extern "C" fn esp_timer_isr_dispatch_need_yield() = "esp_timer_isr_dispatch_need_yield"

///|
pub extern "C" fn esp_timer_is_active(timer : ESPTimer) -> Bool = "esp_timer_is_active"

// TODO
// esp_err_t esp_timer_new_etm_alarm_event(esp_etm_event_handle_t *out_event)
