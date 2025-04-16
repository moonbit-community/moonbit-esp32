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
