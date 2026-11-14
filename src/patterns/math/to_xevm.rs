use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::{FloatKind, ShapedKind, Type};

use crate::patterns;
use crate::{llvm_fastmath, ConversionRewriter, Fmf, OpId, ValueId};

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct MathXevmOptions {
    pub convert_arith: bool,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum Native {
    Exp,
    Cos,
    Exp2,
    Log,
    Log2,
    Log10,
    Powr,
    Rsqrt,
    Sin,
    Sqrt,
    Tan,
    Divide,
}

impl Native {
    const TABLE: [(&'static str, Self, &'static str); 12] = [
        ("math.exp", Self::Exp, "__spirv_ocl_native_exp"),
        ("math.cos", Self::Cos, "__spirv_ocl_native_cos"),
        ("math.exp2", Self::Exp2, "__spirv_ocl_native_exp2"),
        ("math.log", Self::Log, "__spirv_ocl_native_log"),
        ("math.log2", Self::Log2, "__spirv_ocl_native_log2"),
        ("math.log10", Self::Log10, "__spirv_ocl_native_log10"),
        ("math.powf", Self::Powr, "__spirv_ocl_native_powr"),
        ("math.rsqrt", Self::Rsqrt, "__spirv_ocl_native_rsqrt"),
        ("math.sin", Self::Sin, "__spirv_ocl_native_sin"),
        ("math.sqrt", Self::Sqrt, "__spirv_ocl_native_sqrt"),
        ("math.tan", Self::Tan, "__spirv_ocl_native_tan"),
        ("arith.divf", Self::Divide, "__spirv_ocl_native_divide"),
    ];

    fn name(self) -> &'static str {
        Self::TABLE.iter().find(|(_, n, _)| *n == self).map_or("", |(_, _, s)| s)
    }

    fn mangled(self, types: &[Type<'_>]) -> String {
        let base = self.name();
        let mut out = format!("_Z{}{base}", base.len());
        let float = |t: &Type<'_>| match t {
            Type::Float(FloatKind::F32) => "f",
            Type::Float(FloatKind::F16) => "Dh",
            Type::Float(FloatKind::F64) => "d",
            _ => "",
        };
        for t in types {
            match t {
                Type::Shaped(s) if s.kind == ShapedKind::Vector => {
                    let n = match s.shape.as_deref() {
                        Some([mlirformat::Dim::Static(n)]) => *n,
                        _ => 0,
                    };
                    out.push_str(&format!("Dv{n}_{}", float(&s.elem)));
                }
                t => out.push_str(float(t)),
            }
        }
        out
    }

    fn compatible(t: &Type<'_>) -> bool {
        match t {
            Type::Float(_) => true,
            Type::Shaped(s) if s.kind == ShapedKind::Vector => matches!(s.elem.as_ref(), Type::Float(_)) && matches!(s.shape.as_deref(), Some([mlirformat::Dim::Static(2 | 3 | 4 | 8 | 16)])),
            _ => false,
        }
    }
}

impl TryFrom<&str> for Native {
    type Error = ();
    fn try_from(op: &str) -> Result<Self, ()> {
        Self::TABLE.iter().find(|(o, _, _)| *o == op).map(|(_, n, _)| *n).ok_or(())
    }
}

pub struct MathToXevm;

#[patterns(options = MathXevmOptions)]
impl MathToXevm {
    #[convert("math.exp", "math.cos", "math.exp2", "math.log", "math.log2", "math.log10", "math.powf", "math.rsqrt", "math.sin", "math.sqrt", "math.tan", "arith.divf")]
    fn native(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], o: MathXevmOptions) -> bool {
        let Ok(f) = Native::try_from(&*cr.rw.body[op].name) else { return false };
        if f == Native::Divide && !o.convert_arith {
            return false;
        }
        let ty = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
        if !Native::compatible(&ty) || !Fmf::of(cr, op).afn() {
            return false;
        }
        let args: Vec<ValueId> = operands.iter().flatten().copied().collect();
        let types = cr.rw.body.types(&args);
        if !types.iter().all(Native::compatible) {
            return false;
        }
        let Some(module) = cr.module_of(op) else { return false };
        let name = f.mangled(&types);
        if cr.llvm_func(module, &name, types, ty.clone(), false).is_none() {
            return false;
        }
        let fmf = llvm_fastmath(cr.rw.body[op].get("fastmath"));
        cr.rw.set_before(op);
        let call = cr.llvm_call(&name, &args, &[ty]);
        cr.modify(call, |b| b[call].set("fastmathFlags", fmf));
        let r = cr.rw.body[call].results[0];
        cr.replace(op, alloc::vec![alloc::vec![r]]);
        true
    }
}
