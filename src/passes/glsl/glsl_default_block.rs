use alloc::boxed::Box;
use alloc::format;
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::spirv_types::{SpirvDecoration, SpirvMember, SpirvType};
use mlirformat::{Attribute, Dim, Error, Op, Type};

use crate::{A, Body, GlslGlobal, GlslLoad, GlslShader, Heads, OpData, OpId, Quiet, Rewriter, Run, Storage, Symbol, pass};

#[pass("glsl-default-block", on = "builtin.module")]
pub struct GlslDefaultBlock {
    #[opt("binding", default = GlslDefaultBlock::UNSET)]
    binding: u32,
}

struct Std140;

impl Std140 {
    const VEC4: u32 = 16;
    const WORD: u32 = 4;

    fn round(x: u32, a: u32) -> u32 {
        x.div_ceil(a) * a
    }

    fn lanes(t: &Type<'_>) -> Option<u32> {
        match t {
            Type::Shaped(s) => match s.shape.as_deref() {
                Some([Dim::Static(n)]) => u32::try_from(*n).ok(),
                _ => None,
            },
            _ => Some(1),
        }
    }

    fn layout(t: &Type<'_>) -> Result<(u32, u32), Error> {
        Ok(match SpirvType::try_from(t) {
            Ok(SpirvType::Matrix { cols, .. }) => (Std140::VEC4, cols * Std140::VEC4),
            Ok(SpirvType::Array { len, elem, .. }) => (Std140::VEC4, Std140::stride(&elem)? * len),
            Ok(SpirvType::Struct { members: Some(m), .. }) => {
                let (_, align, size) = Std140::members(&m.iter().map(|x| x.ty.clone()).collect::<Vec<_>>())?;
                (align, size)
            }
            Ok(other) => return Err(Error(format!("glsl-default-block: {other:?} in a uniform"))),
            Err(_) => match Std140::lanes(t) {
                Some(1) => (Std140::WORD, Std140::WORD),
                Some(2) => (2 * Std140::WORD, 2 * Std140::WORD),
                Some(n) => (Std140::VEC4, n * Std140::WORD),
                None => return Err(Error(format!("glsl-default-block: {t} in a uniform"))),
            },
        })
    }

    fn stride(t: &Type<'_>) -> Result<u32, Error> {
        let (a, size) = Std140::layout(t)?;
        Ok(Std140::round(size.max(a), Std140::VEC4))
    }

    fn members(tys: &[Type<'_>]) -> Result<(Vec<u32>, u32, u32), Error> {
        let mut offsets = Vec::new();
        let (mut at, mut align) = (0, Std140::VEC4);
        for t in tys {
            let (a, size) = Std140::layout(t)?;
            at = Std140::round(at, a);
            offsets.push(at);
            at += size;
            align = align.max(a);
        }
        let align = Std140::round(align, Std140::VEC4);
        Ok((offsets, align, Std140::round(at, align)))
    }

    fn word<'a>(t: &Type<'a>) -> Type<'a> {
        match t {
            Type::Integer { width: 1, .. } => Type::int(32),
            Type::Shaped(s) if *s.elem == Type::I1 => Type::vector(&[i64::from(Std140::lanes(t).unwrap_or(1))], &[], Type::int(32)),
            t => t.clone(),
        }
    }

    fn laid<'a>(t: &Type<'a>) -> Result<Type<'a>, Error> {
        Ok(match SpirvType::try_from(t) {
            Ok(SpirvType::Array { len, elem, .. }) => SpirvType::Array { len, elem: Box::new(Std140::laid(&elem)?), stride: Std140::stride(&elem)? }.into(),
            Ok(SpirvType::Struct { members: Some(m), .. }) => {
                let tys: Vec<Type<'a>> = m.into_iter().map(|x| x.ty).collect();
                Std140::block(&tys, Vec::new())?
            }
            _ => Std140::word(t),
        })
    }

    fn innermost<'t>(t: &Type<'t>) -> Type<'t> {
        match SpirvType::try_from(t) {
            Ok(SpirvType::Array { elem, .. }) => Std140::innermost(&elem),
            _ => t.clone(),
        }
    }

    fn member<'a>(t: &Type<'a>, offset: u32) -> Result<SpirvMember<'a>, Error> {
        let decorations = match SpirvType::try_from(&Std140::innermost(t)) {
            Ok(SpirvType::Matrix { .. }) => vec![SpirvDecoration { name: String::from("ColMajor"), value: None }, SpirvDecoration { name: String::from("MatrixStride"), value: Some(format!("{}", Std140::VEC4)) }],
            _ => Vec::new(),
        };
        Ok(SpirvMember { ty: Std140::laid(t)?, offset: Some(offset), decorations })
    }

    fn leaves(t: &Type<'_>, at: u32, out: &mut Vec<u32>) -> Result<(), Error> {
        match SpirvType::try_from(t) {
            Ok(SpirvType::Array { len, elem, .. }) => {
                let stride = Std140::stride(&elem)?;
                (0..len).try_for_each(|i| Std140::leaves(&elem, at + i * stride, out))
            }
            Ok(SpirvType::Struct { members: Some(m), .. }) => {
                let tys: Vec<Type<'_>> = m.into_iter().map(|x| x.ty).collect();
                let (offsets, _, _) = Std140::members(&tys)?;
                tys.iter().zip(offsets).try_for_each(|(t, o)| Std140::leaves(t, at + o, out))
            }
            _ => {
                out.push(at);
                Ok(())
            }
        }
    }

    fn block<'a>(tys: &[Type<'a>], decorations: Vec<SpirvDecoration>) -> Result<Type<'a>, Error> {
        let (offsets, _, _) = Std140::members(tys)?;
        let members = tys.iter().zip(offsets).map(|(t, o)| Std140::member(t, o)).collect::<Result<Vec<_>, _>>()?;
        Ok(SpirvType::Struct { name: None, members: Some(members), decorations }.into())
    }
}

impl GlslDefaultBlock {
    pub const NAME: &'static str = "gl_DefaultUniformBlock";
    const UNSET: u32 = u32::MAX;
    pub const LOCATIONS: &'static str = "locations";
    pub const OFFSETS: &'static str = "offsets";

    fn loose(g: &GlslGlobal<'_>) -> bool {
        g.storage == Storage::Uniform && !GlslDefaultBlock::opaque_or_block(&g.ty)
    }

    fn opaque_or_block(t: &Type<'_>) -> bool {
        match SpirvType::try_from(t) {
            Ok(SpirvType::SampledImage(_) | SpirvType::Image { .. } | SpirvType::Sampler) => true,
            Ok(SpirvType::Struct { decorations, .. }) => decorations.iter().any(|d| d.name == "Block"),
            _ => false,
        }
    }

    fn shader<'a>(&self, body: &mut Body<'a>, shader: OpId) -> Result<(), Error> {
        let mut found = Vec::new();
        for g in body.ops(body.top_block(shader)) {
            if *body[g].name == *GlslGlobal::NAME {
                let head = body.head::<GlslGlobal>(g)?;
                if GlslDefaultBlock::loose(&head) {
                    let name = String::from(Symbol::defined(&head.sym_name)?);
                    let location = head.location.ok_or_else(|| Error(format!("glsl-default-block: uniform {name} has no location (run glsl-link first)")))?;
                    found.push((location, name, head.ty.clone(), g));
                }
            }
        }
        if found.is_empty() {
            return Ok(());
        }
        if self.binding == GlslDefaultBlock::UNSET {
            return Err(Error(String::from("glsl-default-block: give the block a binding (binding=N)")));
        }
        found.sort_by_key(|f| f.0);
        let tys: Vec<Type<'a>> = found.iter().map(|f| f.2.clone()).collect();
        let ty = Std140::block(&tys, vec![SpirvDecoration { name: String::from("Block"), value: None }])?;
        let mut loads = Vec::new();
        body.walk(shader, &mut |o| loads.push(o));
        loads.retain(|&o| *body[o].name == *GlslLoad::NAME);
        let word = |v: u32| Attribute::of_int(i128::from(v), Type::int(32));
        let locations = Attribute::Array(found.iter().map(|f| word(f.0)).collect());
        let (starts, _, _) = Std140::members(&tys)?;
        let mut offsets = Vec::new();
        for (f, start) in found.iter().zip(starts) {
            let mut leaves = Vec::new();
            Std140::leaves(&f.2, start, &mut leaves)?;
            offsets.extend(leaves.into_iter().zip(f.0..).map(|(o, l)| Attribute::Array(vec![word(l), word(o)])));
        }
        let data = OpData::build(GlslGlobal::NAME)
            .with("sym_name", Attribute::str(GlslDefaultBlock::NAME))
            .with("ty", Attribute::Type(ty))
            .with("storage", A::from(Storage::Uniform as i64).into())
            .with("binding", word(self.binding))
            .with(GlslDefaultBlock::LOCATIONS, locations)
            .with(GlslDefaultBlock::OFFSETS, Attribute::Array(offsets));
        let mut quiet = Quiet;
        let mut rw = Rewriter::new(body, &mut quiet);
        rw.set_before(found[0].3);
        rw.create(data, &[]);
        for load in loads {
            let Some(var) = rw.body[load].get("var").and_then(|v| match v {
                Attribute::SymbolRef(p) if p.len() == 1 => Some(String::from(p[0].trim_matches('"'))),
                _ => None,
            }) else {
                continue;
            };
            let Some(k) = found.iter().position(|f| f.1 == var) else { continue };
            rw.set_before(load);
            let at = rw.create(OpData::build("arith.constant").with("value", word(u32::try_from(k).unwrap_or(u32::MAX))), &[Type::int(32)]);
            let mut operands = vec![rw.body[at].results[0]];
            operands.extend(rw.body[load].operands.iter().copied());
            let result = rw.body[load].results[0];
            let ty = rw.body[result].ty.clone();
            let new = rw.create(OpData::build(GlslLoad::NAME).operands(&operands).with("var", Attribute::SymbolRef(vec![String::from(GlslDefaultBlock::NAME).into()])), &[ty]);
            let v = rw.body[new].results[0];
            rw.replace_all_uses(result, v);
            rw.erase_op(load);
        }
        for f in found {
            rw.erase_op(f.3);
        }
        Ok(())
    }
}

impl Run for GlslDefaultBlock {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let mut shaders = Vec::new();
        body.walk(op, &mut |o| shaders.push(o));
        shaders.retain(|&o| *body[o].name == *GlslShader::NAME);
        for s in shaders {
            self.shader(body, s)?;
        }
        Ok(())
    }
}
