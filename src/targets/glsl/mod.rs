//! GLSL source, read into mlirformat's `glsl` dialect and written back (`GlslFormat`), and a
//! `spirv.module` written as GLSL 4.50 for Vulkan (`SpirvGlsl`).

mod read;
mod spirv;
mod write;

pub use spirv::SpirvGlsl;

use alloc::string::String;
use alloc::vec;

use mlirformat::glsl::{GlslDialect, GlslStage};
use mlirformat::{Dialect, Error, Item, MlirOpt, Module, OpInfos, Operation};

use crate::{Body, Emit, OpId, Shift};

use read::GlslReader as Parser;

/// GLSL (ES 1.00 / 3.00) source: read into mlirformat's `glsl` dialect (`glsl.shader`, its globals,
/// built-ins and texture ops, the rest as `func` / `arith` / `math` / `vector` / `scf` and SPIR-V
/// control flow and types)
pub struct GlslFormat {
    /// The stage the source is; when not given, a vertex shader if it writes `gl_Position`
    pub stage: Option<GlslStage>,
    opt: MlirOpt,
    infos: OpInfos,
}

impl GlslFormat {
    /// What a vertex shader writes
    const POSITION: &'static str = "gl_Position";
    /// What a shader's source starts with, comments and blank lines aside
    const VERSION: &'static str = "#version";

    pub fn new(stage: Option<GlslStage>) -> Self {
        let mut infos = OpInfos::upstream();
        for i in GlslDialect.op_infos() {
            infos.insert(i);
        }
        let mut opt = MlirOpt::upstream();
        opt.load(GlslDialect);
        Self { stage, opt, infos }
    }

    fn stage_of(&self, src: &str) -> GlslStage {
        self.stage.unwrap_or(if src.contains(Self::POSITION) { GlslStage::Vertex } else { GlslStage::Fragment })
    }

    /// The source with its comments and leading blank lines left out
    fn head(src: &str) -> &str {
        let mut rest = src.trim_start();
        loop {
            if let Some(r) = rest.strip_prefix("//") {
                rest = r.split_once('\n').map_or("", |(_, r)| r).trim_start();
            } else if let Some(r) = rest.strip_prefix("/*") {
                rest = r.split_once("*/").map_or("", |(_, r)| r).trim_start();
            } else {
                return rest;
            }
        }
    }
}

impl Default for GlslFormat {
    fn default() -> Self {
        Self::new(None)
    }
}

impl GlslFormat {
    /// Whether `bytes` are GLSL source (`#version` first, comments aside)
    pub fn recognizes(bytes: &[u8]) -> bool {
        core::str::from_utf8(bytes).is_ok_and(|s| Self::head(s).starts_with(Self::VERSION))
    }

    /// GLSL source as a `glsl.shader` op
    pub fn read(&self, src: &str) -> Result<Operation<'static>, Error> {
        let (tree, op) = Parser::read(src, self.stage_of(src), &self.opt)?;
        Ok(tree.operation(op, &self.infos))
    }

    /// A `glsl.shader` op as GLSL source
    pub fn write(op: &Operation<'_>) -> Result<String, Error> {
        write::Writer::new(op)?.write()
    }
}

/// Reads GLSL source into a body: the `glsl.shader` op goes at the end of the body's top block
pub struct GlslReader;

impl GlslReader {
    pub fn read(body: &mut Body<'_>, src: &str, stage: GlslStage) -> Result<OpId, Error> {
        let op = GlslFormat::new(Some(stage)).read(src)?;
        let sub = Body::import(body.ctx, Module { items: vec![Item::Op(op)] })?;
        let shader = sub.first_op(sub.top_block(sub.root)).ok_or_else(|| Error::from("glsl: no shader was read"))?;
        let moved = shader.shift(&body.absorb(sub));
        body.detach(moved);
        let top = body.top_block(body.root);
        body.insert(moved, top, None);
        Ok(moved)
    }
}

impl Emit for SpirvGlsl {
    type Output = String;

    fn emit(&self, body: &Body<'_>, op: OpId) -> Result<String, Error> {
        SpirvGlsl::text(&body.operation(op))
    }
}
