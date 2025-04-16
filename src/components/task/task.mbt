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
extern "C" fn _xTaskCreate(
  pxTaskCode : FuncRef[(@ctypes.Ptr[@ctypes.Void]) -> Unit],
  pcName : @ctypes.CString,
  usStackDepth : UInt,
  uxPriority : UInt
) -> Int = "__wrap_xTaskCreate"

///|
pub fn xTaskCreate(
  pxTaskCode : FuncRef[(@ctypes.Ptr[@ctypes.Void]) -> Unit],
  pcName : @ctypes.CString,
  usStackDepth : UInt,
  uxPriority : UInt
) -> Int {
  _xTaskCreate(pxTaskCode, pcName, usStackDepth, uxPriority)
}

///|
extern "C" fn _vTaskDelay(ticks : Int) -> Unit = "__wrap_vTaskDelay"

///|
pub fn vTaskDelay(ticks : Int) -> Unit {
  _vTaskDelay(ticks)
}

///|
pub extern "C" fn pdMS_TO_TICKS(ms : Int) -> Int = "__wrap_pdMS_TO_TICKS"
