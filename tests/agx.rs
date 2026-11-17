//! AGX lowering and images: a CDM stream laid out as Mesa writes one, kernels as acgpu runs them
//! (encoding and packing are mlirbinary's tests)

use mlirformat::{MlirOpt, Module};
use mlirpass::{AgxDialect, Body, Ctx, Interfaces};

#[test]
fn cdm_stream_as_mesa() {
    use mlirpass::{AGX_IMAGE, Emit, ImageDialect, PassManager, Passes};
    let mut opt = MlirOpt::upstream();
    opt.load(AgxDialect);
    opt.load(ImageDialect);
    let interfaces = Interfaces::upstream();
    let passes = Passes::upstream();
    let mut body = Body::parse(Ctx::new(&opt, &interfaces), include_str!("agx/cdm.mlir")).unwrap();
    let root = body.root;
    PassManager::parse(&passes, "builtin.module(agx-end, agx-layout)").unwrap().run(&mut body, root).unwrap();
    let show = || opt.show(&Module::from(&body)).to_string();
    let image = AGX_IMAGE.emit(&body, root).unwrap_or_else(|e| panic!("{e}\n{}", show()));
    let code = image.segment("code").unwrap();
    let want: Vec<u8> = include_str!("agx/cdm.expected").lines().map(|l| u8::from_str_radix(l, 16).unwrap()).collect();
    let at = (image.stream - code.addr) as usize;
    assert_eq!(&code.bytes[at..at + want.len()], &want[..], "\n{}", show());
    assert_eq!(image.stream_end - image.stream, want.len() as u64);
}

#[test]
fn kernels_as_acgpu() {
    use mlirpass::{AgxEmit, Emit, PassManager, Passes};
    let mut opt = MlirOpt::upstream();
    opt.load(AgxDialect);
    let interfaces = Interfaces::upstream();
    let passes = Passes::upstream();
    let mut body = Body::parse(Ctx::new(&opt, &interfaces), include_str!("agx/ints.mlir")).unwrap();
    let root = body.root;
    PassManager::parse(&passes, "builtin.module(gpu-inline-calls, canonicalize, cse, convert-gpu-to-agx, agx-regalloc, agx-wait)").unwrap().run(&mut body, root).unwrap();
    let [k] = &AgxEmit.emit(&body, root).unwrap()[..] else { panic!("one kernel") };
    let got = format!("params={} gprs={} align={}\n", k.params, k.gprs, k.align) + &k.bytes.chunks(32).map(|c| c.iter().map(|b| format!("{b:02x}")).collect::<String>() + "\n").collect::<String>();
    assert_eq!(got, include_str!("agx/ints.expected"));
}
