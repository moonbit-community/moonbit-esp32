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

#include <freertos/FreeRTOS.h>
#include <freertos/task.h>
#include <stdint.h>

int32_t __wrap_xTaskCreate(void *pxTaskCode, uint8_t *pcName,
                           uint32_t usStackDepth, uint32_t uxPriority) {
  int32_t ret = xTaskCreate(pxTaskCode, (char *)pcName, usStackDepth, NULL,
                            uxPriority, NULL);
  return ret;
}

void __wrap_vTaskDelay(int32_t xTicksToDelay) { vTaskDelay(xTicksToDelay); }

int32_t __wrap_pdMS_TO_TICKS(int32_t xTimeInMs) {
  return pdMS_TO_TICKS(xTimeInMs);
}
