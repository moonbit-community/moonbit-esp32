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

#include "esp_timer.h"
#include "moonbit.h"

esp_timer_handle_t __wrap_esp_timer_create(void (*callback)(void *),
                                           void *arg) {
  esp_timer_handle_t handle;
  esp_timer_create_args_t timer_args = {
      .callback = callback,
      .arg = arg,
  };
  esp_err_t err = esp_timer_create(&timer_args, &handle);
  // todo: check err
  return handle;
}

int __wrap_esp_timer_start_once(esp_timer_handle_t timer, int64_t timeout_us) {
  esp_err_t err = esp_timer_start_once(timer, timeout_us);
  return err;
}

int __wrap_esp_timer_get_period(esp_timer_handle_t timer, int64_t *timeout_us) {
  esp_err_t err = esp_timer_get_period(timer, timeout_us);
  return err;
}

int __wrap_esp_timer_get_expiry_time(esp_timer_handle_t timer,
                                     int64_t *expiry) {
  esp_err_t err = esp_timer_get_expiry_time(timer, expiry);
  return err;
}
