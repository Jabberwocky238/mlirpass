use core::str::FromStr;

use mlirformat::Error;

use crate::pass;
use crate::{Body, Canonicalize, Cse, Inline, LoopInvariantCodeMotion, Mem2Reg, OpId, PassManager, RemoveDeadValues, Run, Sccp, Sroa, SymbolDce};

/// How hard `optimize` works, as clang's `-O0` .. `-O3`: which passes run, in LLVM's order
/// (`PassBuilder::buildO1FunctionSimplificationPipeline` / `buildFunctionSimplificationPipeline`)
/// with this crate's passes for LLVM's, and which instruction selector a CPU target uses.
#[derive(Clone, Copy, Debug, Default, PartialEq, Eq, PartialOrd, Ord, Hash)]
pub enum OptLevel {
    /// Nothing: the IR as written; LLVM's fast selector.
    O0,
    /// Promotion to registers, constant propagation, local simplification and CSE, loop-invariant
    /// code motion; no inlining.
    O1,
    /// `O1` with inlining (callees up to this size against the caller), and the simplification
    /// run again over what inlining exposed, unused functions dropped.
    #[default]
    O2,
    /// `O2` with a larger inlining budget, dead values removed across functions, one more round.
    O3,
}

impl FromStr for OptLevel {
    type Err = ();

    fn from_str(s: &str) -> Result<Self, ()> {
        match s {
            "O0" | "0" => Ok(OptLevel::O0),
            "O1" | "1" => Ok(OptLevel::O1),
            "O2" | "2" => Ok(OptLevel::O2),
            "O3" | "3" => Ok(OptLevel::O3),
            _ => Err(()),
        }
    }
}

impl OptLevel {
    /// The largest callee `inline` takes, in percent of its caller's size (MLIR's
    /// `inlining-threshold`).
    const INLINE_O2: u64 = 100;
    const INLINE_O3: u64 = 300;

    /// The passes of this level, on a `builtin.module`.
    pub fn pipeline(self) -> Result<PassManager, Error> {
        let mut pm = PassManager::on("builtin.module");
        match self {
            OptLevel::O0 => {}
            OptLevel::O1 => {
                Self::simplify(&mut pm)?;
            }
            OptLevel::O2 => {
                pm.add_pass::<Sccp>("")?;
                pm.add_pass::<Inline>(&alloc::format!("inlining-threshold={}", Self::INLINE_O2))?;
                Self::simplify(&mut pm)?;
                pm.add_pass::<SymbolDce>("")?;
            }
            OptLevel::O3 => {
                pm.add_pass::<Sccp>("")?;
                pm.add_pass::<Inline>(&alloc::format!("inlining-threshold={}", Self::INLINE_O3))?;
                Self::simplify(&mut pm)?;
                pm.add_pass::<RemoveDeadValues>("")?;
                Self::simplify(&mut pm)?;
                pm.add_pass::<SymbolDce>("")?;
            }
        }
        Ok(pm)
    }

    /// One round of function simplification: SROA and promotion to registers (`SROAPass`,
    /// `mem2reg`), constant propagation (`SCCPPass`), `InstCombine` + `SimplifyCFG`
    /// (`canonicalize`), `EarlyCSE` / `GVN` (`cse`), `LICM`, and the clean-up after it.
    fn simplify(pm: &mut PassManager) -> Result<(), Error> {
        pm.add_pass::<Sroa>("")?;
        pm.add_pass::<Mem2Reg>("")?;
        pm.add_pass::<Sccp>("")?;
        pm.add_pass::<Canonicalize>("")?;
        pm.add_pass::<Cse>("")?;
        pm.add_pass::<LoopInvariantCodeMotion>("")?;
        pm.add_pass::<Canonicalize>("")?;
        pm.add_pass::<Cse>("")?;
        Ok(())
    }
}

/// The optimization pipeline of a level (`optimize{level=O2}`).
#[pass("optimize", on = "builtin.module")]
pub struct Optimize {
    #[opt("level", default = OptLevel::O2, from_str)]
    level: OptLevel,
}

impl Run for Optimize {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let mut pm = self.level.pipeline()?;
        pm.set_verify_each(false);
        pm.run(body, op)
    }
}
