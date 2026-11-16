use alloc::format;
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Error, Op};

use crate::{A, Fill, OpData, RDNA2_PARAMS as PARAMS, RDNA2_WORKGROUP as WORKGROUP};
use crate::{
    Pm4DispatchDirect, RDNA2, RegComputeDispatchInitiator, RegComputeDispatchTunnel, RegComputeNumThreadX, RegComputeNumThreadY, RegComputeNumThreadZ, RegComputePgmHi, RegComputePgmLo, RegComputePgmRsrc1,
    RegComputePgmRsrc2, RegComputePgmRsrc3, RegComputeResourceLimits, RegComputeStaticThreadMgmtSe0, RegComputeStaticThreadMgmtSe1, RegComputeStaticThreadMgmtSe2,
    RegComputeStaticThreadMgmtSe3, RegComputeUserAccum0, RegComputeUserAccum1, RegComputeUserAccum2, RegComputeUserAccum3, RegComputeUserData0, RegComputeUserData1,
    RegComputeUserData2, RegComputeUserData3, RegComputeUserData4, RegComputeUserData5, RegComputeUserData6, RegComputeUserData7, RegCpCoherStartDelay, RegTaCsBcBaseAddr,
    RegTaCsBcBaseAddrHi, Rdna2Word as Word,
};

pub struct Rdna2Dispatch {
    pub kernel: String,
    pub vgprs: u32,
    pub groups: [u32; 3],
    pub params: Vec<A>,
    pub shader_engines: u32,
}

impl Rdna2Dispatch {
    fn reg<'a, O>(r: &O) -> OpData<'a>
    where
        for<'o> mlirformat::Operation<'static>: TryFrom<&'o O, Error = Error>,
    {
        OpData::of(r).expect("a register op serializes").0
    }

    fn value<O: Op>(r: &O) -> Result<u32, Error>
    where
        for<'o> mlirformat::Operation<'static>: TryFrom<&'o O, Error = Error>,
    {
        Ok(RDNA2.pack(O::NAME, &Rdna2Dispatch::reg(r).all_attrs())?[0])
    }

    pub fn ops<'a>(&self) -> Result<Vec<OpData<'a>>, Error> {
        if self.params.len() > PARAMS {
            return Err(Error(format!("{} parameters, a kernel takes {PARAMS}", self.params.len())));
        }
        let n = |v: u32| Some(Fill::from(v));
        let cu = |se: u32| n(if se < self.shader_engines { 0xffff } else { 0 });
        let mut ops = vec![
            Rdna2Dispatch::reg(&RegCpCoherStartDelay { start_delay_count: n(0x20), ..Default::default() }),
            Rdna2Dispatch::reg(&RegTaCsBcBaseAddr { value: n(0), ..Default::default() }),
            Rdna2Dispatch::reg(&RegTaCsBcBaseAddrHi { address: n(0), ..Default::default() }),
            Rdna2Dispatch::reg(&RegComputePgmHi { data: n(0), ..Default::default() }),
            Rdna2Dispatch::reg(&RegComputeStaticThreadMgmtSe0 { sh0_cu_en: cu(0), sh1_cu_en: cu(0), ..Default::default() }),
            Rdna2Dispatch::reg(&RegComputeStaticThreadMgmtSe1 { sh0_cu_en: cu(1), sh1_cu_en: cu(1), ..Default::default() }),
            Rdna2Dispatch::reg(&RegComputeStaticThreadMgmtSe2 { sh0_cu_en: cu(2), sh1_cu_en: cu(2), ..Default::default() }),
            Rdna2Dispatch::reg(&RegComputeStaticThreadMgmtSe3 { sh0_cu_en: cu(3), sh1_cu_en: cu(3), ..Default::default() }),
            Rdna2Dispatch::reg(&RegComputeUserAccum0 { contribution: n(0), ..Default::default() }),
            Rdna2Dispatch::reg(&RegComputeUserAccum1 { contribution: n(0), ..Default::default() }),
            Rdna2Dispatch::reg(&RegComputeUserAccum2 { contribution: n(0), ..Default::default() }),
            Rdna2Dispatch::reg(&RegComputeUserAccum3 { contribution: n(0), ..Default::default() }),
            Rdna2Dispatch::reg(&RegComputeDispatchTunnel::default()),
            Rdna2Dispatch::reg(&RegComputePgmLo { address: Some(Fill::at(self.kernel.clone(), 0)), ..Default::default() }),
            Rdna2Dispatch::reg(&RegComputePgmRsrc1 { vgprs: n((self.vgprs.max(1) - 1) / 8), float_mode: n(0xf0), dx10_clamp: n(1), mem_ordered: n(1), ..Default::default() }),
            Rdna2Dispatch::reg(&RegComputePgmRsrc2 { user_sgpr: n(PARAMS as u32), tgid_x_en: n(1), tgid_y_en: n(1), tgid_z_en: n(1), ..Default::default() }),
            Rdna2Dispatch::reg(&RegComputePgmRsrc3::default()),
            Rdna2Dispatch::reg(&RegComputeResourceLimits::default()),
            Rdna2Dispatch::reg(&RegComputeNumThreadX { num_thread_full: n(WORKGROUP), ..Default::default() }),
            Rdna2Dispatch::reg(&RegComputeNumThreadY { num_thread_full: n(1), ..Default::default() }),
            Rdna2Dispatch::reg(&RegComputeNumThreadZ { num_thread_full: n(1), ..Default::default() }),
        ];
        let user_data: [fn(Option<Fill>) -> OpData<'a>; PARAMS] = [
            |value| Rdna2Dispatch::reg(&RegComputeUserData0 { value, ..Default::default() }),
            |value| Rdna2Dispatch::reg(&RegComputeUserData1 { value, ..Default::default() }),
            |value| Rdna2Dispatch::reg(&RegComputeUserData2 { value, ..Default::default() }),
            |value| Rdna2Dispatch::reg(&RegComputeUserData3 { value, ..Default::default() }),
            |value| Rdna2Dispatch::reg(&RegComputeUserData4 { value, ..Default::default() }),
            |value| Rdna2Dispatch::reg(&RegComputeUserData5 { value, ..Default::default() }),
            |value| Rdna2Dispatch::reg(&RegComputeUserData6 { value, ..Default::default() }),
            |value| Rdna2Dispatch::reg(&RegComputeUserData7 { value, ..Default::default() }),
        ];
        for (p, data) in self.params.iter().zip(user_data) {
            ops.push(data(Some(Fill::try_from(p)?)));
        }
        let initiator = Rdna2Dispatch::value(&RegComputeDispatchInitiator { compute_shader_en: n(1), force_start_at_000: n(1), cs_w32_en: n(1), ..Default::default() })?;
        let body = self.groups.iter().copied().chain([initiator]).map(Word::Dword).collect();
        ops.push(Rdna2Dispatch::reg(&Pm4DispatchDirect { body, compute: true, ..Default::default() }));
        Ok(ops)
    }
}
