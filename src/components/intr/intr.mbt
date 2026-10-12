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
#external
pub type IntrHandle

///|
extern "C" fn _esp_intr_mark_shared(
  intno : Int32,
  cpu : Int32,
  is_in_iram : Bool,
) -> Int32 = "esp_intr_mark_shared"

///|
pub fn esp_intr_mark_shared(
  intno : Int32,
  cpu : Int32,
  is_in_iram : Bool,
) -> Unit raise @error.ESPError {
  @error.esp_err_wrapper(fn() { _esp_intr_mark_shared(intno, cpu, is_in_iram) })
}

///|
extern "C" fn _esp_intr_reserve(intno : Int32, cpu : Int32) -> Int32 = "esp_intr_reserve"

///|
pub fn esp_intr_reserve(
  intno : Int32,
  cpu : Int32,
) -> Unit raise @error.ESPError {
  @error.esp_err_wrapper(fn() { _esp_intr_reserve(intno, cpu) })
}

///|
#owned(ret_handle)
extern "C" fn _esp_intr_alloc(
  source : Int32,
  flags : Int32,
  callback : FuncRef[(() -> Unit) -> Unit],
  closure : () -> Unit,
  ret_handle : Ref[IntrHandle?],
) -> Int32 = "__wrap_esp_intr_alloc"

///|
pub fn esp_intr_alloc(
  source : Int32,
  flags : Int32,
  closure : () -> Unit,
) -> IntrHandle raise @error.ESPError {
  let ret_handle : Ref[IntrHandle?] = @ref.Ref(None)
  @error.esp_err_wrapper(fn() {
    _esp_intr_alloc(source, flags, fn(f) { f() }, closure, ret_handle)
  })
  ret_handle.val.unwrap() // TODO: Handle error
}

// TODO
// esp_err_t esp_intr_alloc_intrstatus(int source, int flags, uint32_t intrstatusreg, uint32_t intrstatusmask, intr_handler_t handler, void *arg, intr_handle_t *ret_handle)

///|
extern "C" fn _esp_intr_free(handle : IntrHandle) -> Int32 = "esp_intr_free"

///|
pub fn esp_intr_free(handle : IntrHandle) -> Unit raise @error.ESPError {
  @error.esp_err_wrapper(fn() { _esp_intr_free(handle) })
}

///|
extern "C" fn _esp_intr_get_cpu(handle : IntrHandle) -> Int32 = "esp_intr_get_cpu"

///|
pub fn esp_intr_get_cpu(handle : IntrHandle) -> Int32 {
  _esp_intr_get_cpu(handle)
}

///|
extern "C" fn _esp_intr_get_intno(handle : IntrHandle) -> Int32 = "esp_intr_get_intno"

///|
pub fn esp_intr_get_intno(handle : IntrHandle) -> Int32 {
  _esp_intr_get_intno(handle)
}

///|
extern "C" fn _esp_intr_disable(handle : IntrHandle) -> Int32 = "esp_intr_disable"

///|
pub fn esp_intr_disable(handle : IntrHandle) -> Unit raise @error.ESPError {
  @error.esp_err_wrapper(fn() { _esp_intr_disable(handle) })
}

///|
extern "C" fn _esp_intr_enable(handle : IntrHandle) -> Int32 = "esp_intr_enable"

///|
pub fn esp_intr_enable(handle : IntrHandle) -> Unit raise @error.ESPError {
  @error.esp_err_wrapper(fn() { _esp_intr_enable(handle) })
}

///|
extern "C" fn _esp_intr_set_in_iram(
  handle : IntrHandle,
  is_in_iram : Bool,
) -> Int32 = "esp_intr_set_in_iram"

///|
pub fn esp_intr_set_in_iram(
  handle : IntrHandle,
  is_in_iram : Bool,
) -> Unit raise @error.ESPError {
  @error.esp_err_wrapper(fn() { _esp_intr_set_in_iram(handle, is_in_iram) })
}

///|
extern "C" fn _esp_intr_noniram_disable() = "esp_intr_noniram_disable"

///|
pub fn esp_intr_noniram_disable() -> Unit {
  _esp_intr_noniram_disable()
}

///|
extern "C" fn _esp_intr_noniram_enable() = "esp_intr_noniram_enable"

///|
pub fn esp_intr_noniram_enable() -> Unit {
  _esp_intr_noniram_enable()
}

///|
extern "C" fn _esp_intr_enable_source(inum : Int32) = "esp_intr_enable_source"

///|
pub fn esp_intr_enable_source(inum : Int32) -> Unit {
  _esp_intr_enable_source(inum)
}

///|
extern "C" fn _esp_intr_disable_source(inum : Int32) = "esp_intr_disable_source"

///|
pub fn esp_intr_disable_source(inum : Int32) -> Unit {
  _esp_intr_disable_source(inum)
}

///|
extern "C" fn _esp_intr_flags_to_level(flags : Int32) -> Int32 = "esp_intr_flags_to_level"

///|
pub fn esp_intr_flags_to_level(flags : Int32) -> Int32 {
  _esp_intr_flags_to_level(flags)
}

///|
extern "C" fn _esp_intr_level_to_flags(level : Int32) -> Int32 = "esp_intr_level_to_flags"

///|
pub fn esp_intr_level_to_flags(level : Int32) -> Int32 {
  _esp_intr_level_to_flags(level)
}
