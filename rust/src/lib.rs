//! # Rust
//!
//! `rust` is for compilation from Rust to a static library for C++
//! To build librust.a:
//! cargo build --package rust --verbose --release
//! , then copy librust.a into expected dir

use std::ffi::CString;
use std::ffi::c_char;
use std::ptr::null_mut;

#[no_mangle]
/// Returns c-style string "hello world!"
pub extern "C" fn get_hello_world() ->  *mut c_char {
    let mut result:  *mut c_char = null_mut();
    if let Ok(s) = CString::new("hello world!") {
        result = s.into_raw();
    }
    result
}

#[no_mangle]
/// Frees result of get_hello_world()
pub extern "C" fn free_hello_world(result: *mut c_char) {
    if !result.is_null() {
        unsafe {
            drop(CString::from_raw(result));
        }
    }
}
