///|
pub type! ESPError {
  Fail
  Other(Int)
} derive(Show)

///|
pub fn esp_err_wrapper(f : () -> Int) -> Unit!ESPError {
  let code = f()
  match code {
    0 => ()
    -1 => raise Fail
    x => raise Other(x)
  }
}
