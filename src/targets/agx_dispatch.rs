//! ⭐ One compute dispatch as agx ops, as Mesa does it (gallium agx_state.c `agx_build_pipeline` / `agx_launch`,
//! libagx_dgc.h `agx_cdm_launch` / `agx_cdm_barrier`, lib/agx_usc.h):
//!
//! - the pipeline (USC words, 64-byte aligned, one after another): USC Uniform (the parameter buffer into uniforms
//!   u0 ...: the 64-bit base, then the parameters), USC Shared (none: `agx_usc_shared_none`), USC Shader (the code's
//!   USC address, unk_2 3), USC Registers (the kernel's GPR halves), USC No Preshader;
//! - the parameter buffer (`image.words`): the base (the USC window, `Agx::BASE`), then each parameter, a place as its
//!   offset from the window (what the shader adds the base to);
//! - the CDM stream: Launch Word 0 (the uniform halves), Launch Word 1 (the pipeline's USC address), Global size (in
//!   threads: workgroups × 16), Local size (16), the barrier Mesa puts after every launch (G13G's bits); agx-end
//!   adds Stream Terminate.

use alloc::format;
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, Error};

use crate::{A, AGX_PARAM_UNIFORM as PARAM_UNIFORM, AGX_PARAMS as PARAMS, AGX_SHARED_LAYOUT_VERTEX_COMPUTE as SHARED_LAYOUT_VERTEX_COMPUTE, AGX_WORKGROUP as WORKGROUP, AgxImage as Agx, Fill, ImageTarget, ImageWords as Words, OpData};
use crate::{CdmBarrier, CdmGlobalSize, CdmLaunchWord0, CdmLaunchWord1, CdmLocalSize, UscNoPreshader, UscRegisters, UscShader, UscShared, UscUniform};

/// ⭐ A dispatch of `kernel` (its symbol) over `groups` workgroups (x) with `params`.
pub struct AgxDispatch {
    pub kernel: String,
    /// The kernel's `gprs` (agx-regalloc).
    pub gprs: u32,
    pub groups: u32,
    /// Numbers, or places (`A::Sym`: passed as their offset from the USC window).
    pub params: Vec<A>,
}

impl AgxDispatch {
    /// `@x - BASE`: a place as the shader's 32-bit address.
    fn offset<'a>(name: &str) -> Attribute<'a> {
        Attribute::Array(vec![A::sym(name).into(), Attribute::Int { lit: format!("-{}", Agx::BASE).into(), ty: None }])
    }

    fn param<'a>(p: &A) -> Attribute<'a> {
        match p {
            A::Sym(s) => AgxDispatch::offset(s),
            other => other.clone().into(),
        }
    }

    /// Struct op `s`, detached.
    fn op<'a, O>(s: &O) -> OpData<'a>
    where
        for<'o> mlirformat::Operation<'static>: TryFrom<&'o O, Error = Error>,
    {
        OpData::of(s).expect("a struct op serializes").0
    }

    /// `@x - BASE` as a field.
    fn place(name: &str) -> Fill {
        Fill::at(name, -(Agx::BASE as i64))
    }

    /// The uniform halves the kernel reads: the base and the parameters.
    fn uniforms(&self) -> u32 {
        PARAM_UNIFORM + 2 * self.params.len() as u32
    }

    /// ⭐ The pipeline's ops (to place in the USC window, each `sym_name` / `align` set), named `pipeline`.
    pub fn pipeline<'a>(&self, params: &str) -> Vec<OpData<'a>> {
        let words = vec![
            AgxDispatch::op(&UscUniform { start_halfs: Some(0.into()), size_halfs: Some(self.uniforms().into()), buffer: Some(Fill::at(params, 0)), ..Default::default() })
                .with("sym_name", A::str("pipeline").into())
                .with("align", A::from(64u32).into()),
            AgxDispatch::op(&UscShared { layout: Some(SHARED_LAYOUT_VERTEX_COMPUTE.into()), bytes_per_threadgroup: Some(65536.into()), ..Default::default() }),
            AgxDispatch::op(&UscShader { unk_2: Some(3.into()), code: Some(AgxDispatch::place(&self.kernel)), ..Default::default() }),
            AgxDispatch::op(&UscRegisters { register_count: Some(self.gprs.into()), ..Default::default() }),
            AgxDispatch::op(&UscNoPreshader::default()),
        ];
        words.into_iter().enumerate().map(|(i, w)| if i == 0 { w } else { w.with("align", A::from(1u32).into()) }).collect()
    }

    /// ⭐ The parameter buffer: `image.words` named `params`.
    pub fn params<'a>(&self) -> Result<OpData<'a>, Error> {
        if self.params.len() > PARAMS {
            return Err(Error(format!("{} parameters, a kernel takes {PARAMS}", self.params.len())));
        }
        let base = [Agx::BASE as u32, (Agx::BASE >> 32) as u32].map(|w| A::from(w).into());
        let values = base.into_iter().chain(self.params.iter().map(AgxDispatch::param)).collect();
        Ok(OpData::of(&Words::new(A::str("params").into(), values, None, None))?.0)
    }

    /// ⭐ The CDM stream's ops.
    pub fn stream<'a>(&self) -> Vec<OpData<'a>> {
        let on = Some(true);
        let barrier = CdmBarrier {
            unk_0: on,
            unk_1: on,
            unk_2: on,
            usc_cache_inval: on,
            unk_4: on,
            unk_5: on,
            unk_6: on,
            unk_7: on,
            unk_8: on,
            unk_9: on,
            unk_10: on,
            unk_11: on,
            unk_12: on,
            unk_13: on,
            unk_14: on,
            unk_15: on,
            unk_16: on,
            unk_17: on,
            unk_18: on,
            unk_19: on,
            ..Default::default()
        };
        let zero = Some(Fill::from(0u32));
        vec![
            AgxDispatch::op(&CdmLaunchWord0 { uniform_register_count: Some(self.uniforms().into()), texture_state_register_count: zero.clone(), preshader_register_count: zero.clone(), mode: zero, ..Default::default() }),
            AgxDispatch::op(&CdmLaunchWord1 { pipeline: Some(AgxDispatch::place("pipeline")), ..Default::default() }),
            AgxDispatch::op(&CdmGlobalSize { x: Some((self.groups * WORKGROUP).into()), y: Some(1.into()), z: Some(1.into()), ..Default::default() }),
            AgxDispatch::op(&CdmLocalSize { x: Some(WORKGROUP.into()), y: Some(1.into()), z: Some(1.into()), ..Default::default() }),
            AgxDispatch::op(&barrier),
        ]
    }
}
