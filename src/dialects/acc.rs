//! The `acc` (OpenACC) dialect's op interfaces: the effects its data clause ops compute in C++
//! (`OpenACC.cpp`).

use alloc::vec::Vec;

use crate::{Body, EffectInstance, EffectKind, OpId, OpInterfaces, Resource};

/// The `acc` dialect.
pub struct AccDialect;

/// One effect of a data clause op.
#[derive(Clone, Copy)]
enum Fx {
    /// On `acc::RuntimeCounters`.
    ReadCounters,
    WriteCounters,
    /// On `acc::CurrentDeviceIdResource`.
    ReadDevice,
    /// On it only outside a compute construct (the private copies).
    ReadDeviceOutside,
    /// On each operand of group `n`.
    ReadOperand(usize),
    WriteOperand(usize),
    /// On the `accVar` result.
    WriteResult,
}

/// `getVar` of an entry op, `getAccVar` / `getVar` of an exit op.
const ENTRY_VAR: usize = 0;
const EXIT_ACC_VAR: usize = 0;
const EXIT_VAR: usize = 1;

use Fx::{ReadCounters as RC, ReadDevice as RD, ReadDeviceOutside as RDO, ReadOperand as RO, WriteCounters as WC, WriteOperand as WO, WriteResult as WR};

/// The ops and their effects, in `getEffects` order.
const EFFECTS: &[(&str, &[Fx])] = &[
    ("acc.attach", &[RC, WC, RD, RO(ENTRY_VAR)]),
    ("acc.cache", &[]),
    ("acc.copyin", &[RC, WC, RD, RO(ENTRY_VAR), WR]),
    ("acc.copyout", &[RC, WC, RD, RO(EXIT_ACC_VAR), WO(EXIT_VAR)]),
    ("acc.create", &[RC, WC, RD, WR]),
    ("acc.declare_device_resident", &[WC, RD, RO(ENTRY_VAR)]),
    ("acc.declare_link", &[WC, RD, RO(ENTRY_VAR)]),
    ("acc.delete", &[RC, WC, RD, RO(EXIT_ACC_VAR)]),
    ("acc.detach", &[RC, WC, RD, RO(EXIT_ACC_VAR)]),
    ("acc.deviceptr", &[RC, RD]),
    ("acc.firstprivate", &[RDO, RO(ENTRY_VAR), WR]),
    ("acc.getdeviceptr", &[RC, RD]),
    ("acc.nocreate", &[RC, WC, RD]),
    ("acc.present", &[RC, WC, RD]),
    ("acc.private", &[RDO, WR]),
    ("acc.reduction", &[RDO, RO(ENTRY_VAR), WR]),
    ("acc.update_device", &[RD, RO(ENTRY_VAR), WR]),
    ("acc.update_host", &[RC, WC, RD, RO(EXIT_ACC_VAR), WO(EXIT_VAR)]),
    ("acc.use_device", &[RC, RD]),
];

/// `ACC_COMPUTE_CONSTRUCT_OPS`.
const COMPUTE_CONSTRUCTS: [&str; 3] = ["acc.parallel", "acc.kernels", "acc.serial"];

impl AccDialect {
    /// `isEnclosedIntoComputeOp`.
    fn in_compute(b: &Body<'_>, op: OpId) -> bool {
        let mut at = b.parent_op(op);
        while let Some(p) = at {
            if COMPUTE_CONSTRUCTS.contains(&&*b[p].name) {
                return true;
            }
            at = b.parent_op(p);
        }
        false
    }
}

impl OpInterfaces for AccDialect {
    fn namespace(&self) -> &str {
        "acc"
    }

    fn effects(&self, b: &Body<'_>, op: OpId) -> Option<Vec<EffectInstance>> {
        let (_, fx) = EFFECTS.iter().find(|(n, _)| *n == &*b[op].name)?;
        let on = |kind, resource| EffectInstance { kind, value: None, resource };
        let mut out = Vec::new();
        for f in *fx {
            match *f {
                Fx::ReadCounters => out.push(on(EffectKind::Read, Resource::AccRuntimeCounters)),
                Fx::WriteCounters => out.push(on(EffectKind::Write, Resource::AccRuntimeCounters)),
                Fx::ReadDevice => out.push(on(EffectKind::Read, Resource::AccCurrentDeviceId)),
                Fx::ReadDeviceOutside if !Self::in_compute(b, op) => out.push(on(EffectKind::Read, Resource::AccCurrentDeviceId)),
                Fx::ReadDeviceOutside => {}
                Fx::ReadOperand(g) => out.extend(b.operand_group(op, g).iter().map(|v| EffectInstance::on(EffectKind::Read, Some(*v)))),
                Fx::WriteOperand(g) => out.extend(b.operand_group(op, g).iter().map(|v| EffectInstance::on(EffectKind::Write, Some(*v)))),
                Fx::WriteResult => out.extend(b[op].results.first().map(|r| EffectInstance::on(EffectKind::Write, Some(*r)))),
            }
        }
        Some(out)
    }
}
