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
