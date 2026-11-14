use crate::{MathToFuncs};
use alloc::format;
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;
use mlirformat::{Error, FunctionType, Type};
use crate::pass;
use crate::{Body, ConversionConfig, ConversionPatterns, ConversionTarget, Converter, Mode, OpId, Run};

#[pass("convert-math-to-funcs", on = "builtin.module")]
pub struct ConvertMathToFuncs {
    #[opt("min-width-of-fpowi-exponent", default = 1)]
    min_width: u32,
    #[opt("convert-ctlz")]
    convert_ctlz: bool,
}

impl ConvertMathToFuncs {
    fn int_result(b: &Body<'_>, op: OpId) -> bool {
        matches!(b[b[op].results[0]].ty.element_type(), Type::Integer { .. })
    }

    fn fpowi_ok(&self, b: &Body<'_>, op: OpId) -> bool {
        let e = b[b[op].operands[1]].ty.element_type();
        matches!(e, Type::Integer { .. }) && MathToFuncs::width(e) >= self.min_width
    }

    fn generate(&self, b: &mut Body<'_>, module: OpId) {
        let mut ops = Vec::new();
        b.walk_post(module, &mut |o| ops.push(o));
        let mut made: Vec<String> = Vec::new();
        for o in ops {
            let key = match &*b[o].name {
                "math.ctlz" if self.convert_ctlz && Self::int_result(b, o) => format!("ctlz {}", MathToFuncs::elem(&b[b[o].results[0]].ty)),
                "math.ipowi" if Self::int_result(b, o) => format!("ipowi {}", MathToFuncs::elem(&b[b[o].results[0]].ty)),
                "math.fpowi" if self.fpowi_ok(b, o) => format!("fpowi {} {}", MathToFuncs::elem(&b[b[o].operands[0]].ty), MathToFuncs::elem(&b[b[o].operands[1]].ty)),
                _ => continue,
            };
            if made.contains(&key) {
                continue;
            }
            made.push(key);
            match &*b[o].name {
                "math.ctlz" => MathToFuncs::ctlz(b, module, MathToFuncs::elem(&b[b[o].results[0]].ty)),
                "math.ipowi" => MathToFuncs::ipowi(b, module, MathToFuncs::elem(&b[b[o].results[0]].ty)),
                _ => {
                    let ft = FunctionType { inputs: b[o].operands.iter().map(|v| MathToFuncs::elem(&b[*v].ty)).collect(), results: vec![MathToFuncs::elem(&b[b[o].results[0]].ty)] };
                    MathToFuncs::fpowi(b, module, ft)
                }
            }
        }
    }
}

impl Run for ConvertMathToFuncs {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        self.generate(body, op);
        let mut patterns = ConversionPatterns::default();
        MathToFuncs::populate(&mut patterns, self.convert_ctlz);
        let mut target = ConversionTarget::default();
        for d in ["arith", "cf", "func", "scf", "vector"] {
            target.legal_dialect(d);
        }
        target.dynamic_op("math.ipowi", |b, o| Some(!ConvertMathToFuncs::int_result(b, o)));
        if self.convert_ctlz {
            target.dynamic_op("math.ctlz", |b, o| Some(!ConvertMathToFuncs::int_result(b, o)));
        }
        let min = self.min_width;
        target.dynamic_op("math.fpowi", move |b, o| {
            let e = b[b[o].operands[1]].ty.element_type();
            Some(!(matches!(e, Type::Integer { .. }) && MathToFuncs::width(e) >= min))
        });
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
    }
}
