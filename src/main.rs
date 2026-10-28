//! The `mlirpass` command line: `mlir-opt`'s, for the passes this crate has.
//!
//! ```text
//! mlirpass in.mlir -split-input-file --convert-to-llvm -o out.mlir
//! ```

use std::io::Read;
use std::process::ExitCode;

use mlirpass::{Ctx, Interfaces, Invocation, Passes};
use mlirpass::mlirformat::MlirOpt;

fn main() -> ExitCode {
    let args: Vec<String> = std::env::args().skip(1).collect();
    match run(&args) {
        Ok(()) => ExitCode::SUCCESS,
        Err(e) => {
            eprintln!("error: {e}");
            ExitCode::FAILURE
        }
    }
}

fn run(args: &[String]) -> Result<(), Box<dyn std::error::Error>> {
    // The managers this run works with: every pass, and every upstream dialect, op and op
    // interface.
    let (passes, opt, interfaces) = (Passes::upstream(), MlirOpt::upstream(), Interfaces::upstream());
    let inv = Invocation::parse(&passes, args)?;
    let src = match inv.input.as_deref() {
        None | Some("-") => {
            let mut s = String::new();
            std::io::stdin().read_to_string(&mut s)?;
            s
        }
        Some(path) => std::fs::read_to_string(path)?,
    };
    let out = inv.run(Ctx::new(&opt, &interfaces), &src)?;
    match inv.output.as_deref() {
        None | Some("-") => print!("{out}"),
        Some(path) => std::fs::write(path, out)?,
    }
    Ok(())
}
