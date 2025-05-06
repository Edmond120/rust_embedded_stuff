#![no_std]
#![no_main]

// pick a panicking behavior
// use panic_abort as _; // requires nightly
// use panic_itm as _; // logs messages over ITM; requires ITM support
#[cfg(debug_assertions)]
use panic_semihosting as _; // logs messages to the host stderr; requires a debugger
#[cfg(not(debug_assertions))]
use panic_halt as _; // you can put a breakpoint on `rust_begin_unwind` to catch panics

use core::sync::atomic::{Ordering, AtomicU32};
use cortex_m_rt::{entry, exception};
use cortex_m_semihosting::hprintln;

#[entry]
fn main() -> ! {
    hprintln!("Hello world").unwrap();
    loop {}
}

#[exception]
fn SysTick() {
    static COUNT: AtomicU32 = AtomicU32::new(0);
    COUNT.fetch_add(1, Ordering::Relaxed);
}
