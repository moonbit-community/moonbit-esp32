///|
pub type CString Bytes

///|
pub fn CString::from_bytes(data : Bytes) -> CString {
  if data.length() == 0 {
    abort("cannot be empty")
  }
  if data[data.length() - 1] != b'\x00' {
    abort("not end with \\x00")
  }
  data
}
