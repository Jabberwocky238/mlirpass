//! `convert-elementwise-to-linalg`.

use crate::{ElementwiseToLinalg};
use alloc::boxed::Box;
use mlirformat::Error;
use crate::{pass, Action, Body, ConversionConfig, ConversionPatterns, ConversionTarget, Converter, Mode, OpId};

/// `convert-elementwise-to-linalg`.
#[pass("convert-elementwise-to-linalg")]
pub fn convert_elementwise_to_linalg<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut patterns = ConversionPatterns::default();
    ElementwiseToLinalg::populate(&mut patterns);
    let mut target = ConversionTarget::default();
    target.unknown(Action::Dynamic(Box::new(|b: &Body<'_>, op: OpId| Some(!ElementwiseToLinalg::applies(b, op)))));
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
}
