use alloc::collections::{BTreeMap, BTreeSet};
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::spirv_types::SpirvType;
use mlirformat::{Attribute, Error, Op, Type};

use crate::{Body, GlslGlobal, GlslShader, GlslStage, Heads, OpId, Quiet, Rewriter, Storage, Symbol, pass};

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum Slot {
    Location,
    Binding,
}

impl Slot {
    const fn attr(self) -> &'static str {
        match self {
            Slot::Location => "location",
            Slot::Binding => "binding",
        }
    }
}

#[derive(Default)]
struct Space {
    named: BTreeMap<String, u32>,
    taken: BTreeSet<u32>,
}

impl Space {
    fn take(&mut self, at: u32, size: u32) {
        self.taken.extend(at..at + size);
    }

    fn assign(&mut self, name: &str, size: u32) -> u32 {
        if let Some(&at) = self.named.get(name) {
            return at;
        }
        let at = (0..).find(|&a| (a..a + size).all(|x| !self.taken.contains(&x))).unwrap_or(0);
        self.take(at, size);
        self.named.insert(String::from(name), at);
        at
    }
}

#[derive(Default)]
struct Linker {
    attributes: Space,
    varyings: Space,
    outputs: Space,
    uniforms: Space,
    samplers: Space,
    blocks: Space,
}

impl Linker {
    fn size(t: &Type<'_>, uniform: bool) -> u32 {
        match SpirvType::try_from(t) {
            Ok(SpirvType::Matrix { cols, .. }) if !uniform => cols,
            Ok(SpirvType::Array { len, elem, .. }) => len * Linker::size(&elem, uniform),
            Ok(SpirvType::Struct { members: Some(m), .. }) => m.iter().map(|x| Linker::size(&x.ty, uniform)).sum(),
            _ => 1,
        }
    }

    fn space(&mut self, stage: GlslStage, g: &GlslGlobal<'_>) -> Option<(&mut Space, Slot)> {
        if g.builtin.is_some() {
            return None;
        }
        let spirv = SpirvType::try_from(&g.ty);
        Some(match (g.storage, stage) {
            (Storage::In, GlslStage::Vertex) => (&mut self.attributes, Slot::Location),
            (Storage::Out, GlslStage::Vertex) | (Storage::In, GlslStage::Fragment) => (&mut self.varyings, Slot::Location),
            (Storage::Out, GlslStage::Fragment) => (&mut self.outputs, Slot::Location),
            (Storage::Private, _) => return None,
            (Storage::Uniform, _) => match spirv {
                Ok(SpirvType::SampledImage(_) | SpirvType::Image { .. } | SpirvType::Sampler) => (&mut self.samplers, Slot::Binding),
                Ok(SpirvType::Struct { .. }) => (&mut self.blocks, Slot::Binding),
                _ => (&mut self.uniforms, Slot::Location),
            },
        })
    }

    fn given(g: &GlslGlobal<'_>, slot: Slot) -> Option<u32> {
        match slot {
            Slot::Location => g.location,
            Slot::Binding => g.binding,
        }
    }
}

#[pass("glsl-link", on = "builtin.module")]
pub fn glsl_link<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut shaders = Vec::new();
    body.walk(op, &mut |o| shaders.push(o));
    shaders.retain(|&o| &*body[o].name == GlslShader::NAME);
    let mut staged = shaders.iter().map(|&s| Ok((body.head::<GlslShader>(s)?.stage, s))).collect::<Result<Vec<_>, Error>>()?;
    staged.sort_by_key(|(stage, _)| *stage as u8);
    let mut globals = Vec::new();
    for &(stage, s) in &staged {
        for g in body.ops(body.top_block(s)) {
            if &*body[g].name == GlslGlobal::NAME {
                globals.push((stage, g, body.head::<GlslGlobal>(g)?));
            }
        }
    }
    let mut linker = Linker::default();
    for (stage, _, g) in &globals {
        if let Some((space, slot)) = linker.space(*stage, g)
            && let Some(at) = Linker::given(g, slot)
        {
            space.take(at, Linker::size(&g.ty, g.storage == Storage::Uniform));
            space.named.insert(String::from(Symbol::defined(&g.sym_name)?), at);
        }
    }
    let mut quiet = Quiet;
    let mut rw = Rewriter::new(body, &mut quiet);
    for (stage, op, g) in &globals {
        let Some((space, slot)) = linker.space(*stage, g) else { continue };
        if Linker::given(g, slot).is_some() {
            continue;
        }
        let name = Symbol::defined(&g.sym_name)?;
        if (*stage, g.storage) == (GlslStage::Fragment, Storage::In) && !space.named.contains_key(name) {
            return Err(Error(format!("glsl-link: the fragment shader reads {name}, which the vertex shader does not write")));
        }
        let at = space.assign(name, Linker::size(&g.ty, g.storage == Storage::Uniform));
        rw.modify(*op, |b| b[*op].set(slot.attr(), Attribute::of_int(i128::from(at), Type::int(32))));
    }
    Ok(())
}
