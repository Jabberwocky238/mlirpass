use core::sync::atomic::AtomicU32;

use mlirformat::Error;

use crate::pass;
use crate::{Body, ConversionConfig, ConversionPatterns, ConversionTarget, Converter, GreedyConfig, Mode, OpId, PatternSet, Run};
use crate::{XevmOptions, XevmToLlvm, XevmVectorExtract};

#[pass("convert-xevm-to-llvm")]
pub struct ConvertXevmToLlvm {
    names: AtomicU32,
    allocas: AtomicU32,
}

impl Run for ConvertXevmToLlvm {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let mut patterns = ConversionPatterns::default();
        XevmToLlvm::populate(&mut patterns, XevmOptions { names: &self.names, allocas: &self.allocas });
        let mut target = ConversionTarget::default();
        XevmToLlvm::target(&mut target);
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)?;
        let mut set = PatternSet::default();
        XevmVectorExtract::patterns(&mut set);
        let config = GreedyConfig { fold: false, ..GreedyConfig::default() };
        for r in body[op].regions.clone() {
            body.apply_greedily(r, &set, &config);
        }
        Ok(())
    }
}
