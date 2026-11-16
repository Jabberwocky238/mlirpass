use mlirformat::{MlirOpt, Op};
use mlirpass::{Body, Builtin, BuiltinVar, Ctx, GlslCall, GlslDialect, GlslGlobal, GlslShader, GlslStage, GlslTexture, Heads, Interfaces, Lod, Storage};

#[test]
fn glsl_prints_and_reads_back() {
    let mut opt = MlirOpt::upstream();
    opt.load(GlslDialect);
    let interfaces = Interfaces::upstream();
    let src = include_str!("glsl/roundtrip.mlir");
    let body = Body::parse(Ctx::new(&opt, &interfaces), src).unwrap_or_else(|e| panic!("{e}"));
    let printed = body.show(&opt, false, |_| true);
    let again = Body::parse(Ctx::new(&opt, &interfaces), &printed).unwrap_or_else(|e| panic!("{e}\n{printed}"));
    assert_eq!(again.show(&opt, false, |_| true), printed);
    if std::env::var_os("SHOW").is_some() {
        println!("{printed}");
    }

    let mut ops = Vec::new();
    body.walk(body.root, &mut |o| ops.push(o));
    let body = &body;
    let named = |name: &'static str| ops.iter().copied().filter(move |&o| &*body[o].name == name);
    let shader = body.head::<GlslShader>(named(GlslShader::NAME).next().unwrap()).unwrap();
    assert_eq!((shader.stage, shader.version, shader.es), (GlslStage::Vertex, 300, true));
    let globals: Vec<GlslGlobal> = named(GlslGlobal::NAME).map(|o| body.head::<GlslGlobal>(o).unwrap()).collect();
    assert_eq!(globals.len(), 7);
    assert_eq!(globals[0].storage, Storage::In);
    assert_eq!(globals[6].builtin, Some(BuiltinVar::Position));
    let call = body.head::<GlslCall>(named(GlslCall::NAME).next().unwrap()).unwrap();
    assert_eq!(call.func, Builtin::MatrixTimesVector);
    let tex = body.head::<GlslTexture>(named(GlslTexture::NAME).next().unwrap()).unwrap();
    assert_eq!((tex.lod, tex.extras.len()), (Lod::Explicit, Lod::Explicit.operands()));
}
