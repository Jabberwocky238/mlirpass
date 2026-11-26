# mlirpass

[English](README.md)

用 Rust 写的 MLIR pass，包括可变 IR、模式改写、方言转换、pass 管理器，以及上游的下降和变换。它建立在
[mlirformat](https://github.com/Jabberwocky238/mlirformat) 之上；mlirformat 负责语法、方言和 MLIR 字节码
（MLIR 文本 ⇄ IR ⇄ 类型化的 Rust op）。

六个 target：上游 MLIR `mlir/lib/Target` 的四个，加上从 llvm 方言出 CPU 机器码的两个（见下文「CPU 机器码」）。
- `llvm`
- `emitc`
- `spirv`：SPIR-V 二进制的写出和读入，和 `mlir-translate` 一样。
- `glsl`：GLSL 源码的读入和写出。
- `x86_64`、`aarch64`：机器码。

GPU 自家的机器码不在这里：[detour](https://github.com/0x00-Community/detour) 以插件方式加入它的 GPU 方言和下降
（`MlirOpt::load`、`Passes::with`）。

MLIR 行为对齐 **MLIR 23.1.5**（llvm-project `llvmorg-23.1.5`）：每个 pass 都对照 `mlir-opt` 23.1.5 对同一输入和
流水线的输出核对。

## 现状

**fixture 对拍**
- 已移植的 pass 的每个 fixture 用例都和 `mlir-opt` 23.1.5 逐字节一致：7616 例。
- 8287 例里其余 671 例跑的是还没移植的 pass；`cargo test --test passes -- --nocapture` 按组计数。
- 含 MLIR 自己的 `Dialect/SPIRV`、`Dialect/GPU`、`*ToSPIRV` 测试。

**三家 GPU 厂商的下降**
- Intel：`convert-xegpu-to-xevm`、`convert-vector-to-xegpu`、`convert-gpu-to-llvm-spv`、`convert-math-to-xevm`、
  xevm ⇒ llvm。
- NVIDIA：`convert-gpu-to-nvvm`、`convert-nvgpu-to-nvvm`、`convert-nvvm-to-llvm`。
- AMD：`convert-gpu-to-rocdl`、`convert-amdgpu-to-rocdl`、`convert-arith-to-amdgpu`、`convert-math-to-rocdl`、
  `convert-complex-to-rocdl-library-calls`。

**Vulkan 上实跑**（`cargo test --test vulkan`）
- MLIR 的 13 个 `Integration/GPU/Vulkan` 测试，以 SPIR-V 和以 GLSL 两种方式在 Vulkan（lavapipe）上跑，
  都得出检查期望的数值。
- 设置 `VULKAN_ICD=/usr/share/vulkan/icd.d/intel_icd.json` 后在 Intel GPU 上跑（Panther Lake 核显上核对过）。
  在那里，用设备自己的 target env（`tests/support/vkinfo.c`）下降的 KHR 协作矩阵 kernel 也对照主机算出的乘积核对。

| 部分 | 是什么 | 对应上游 |
|---|---|---|
| `ir` | 带 use-def 链的 arena IR（op 的操作数、结果、后继和区域最多两个内联，`Ids`）；`Module` ⇄ IR；直接从 IR 打印（`Body::show`，经 mlirformat 的 `Source` 读回）；克隆（`Mapping`） | `mlir/IR` |
| `pass` | pass 管理器、`--pass-pipeline` 语法、注册表（`registry.gen.rs`）、`mlir-opt` 命令行（`Invocation`）、每个 pass 之后跑的校验器；`Exec` 是 [moremath](https://crates.io/crates/moremath) 的 `ThreadMulti` 或任意 `Executor`（和 mlirformat 的 `parse_in` / `print_in` 收的同一种）。对隔离的 op（函数）跑的嵌套流水线作为并行任务执行 | `mlir/Pass`、`OpToOpPassAdaptor`、`MlirOptMain` |
| `rewrite` | 模式、改写器、贪心和遍历驱动 | `PatternMatch`、`GreedyPatternRewriteDriver`、`WalkPatternRewriteDriver` |
| `region` | 区域化简（不可达块、区域 DCE、块合并）和支配关系 | `RegionUtils`、`Dominance` |
| `conversion` | 转换目标、类型转换器、方言转换、作为模式的 `#[convert]`、`convert-to-*` 询问的 `DialectInterfaces` trait | `DialectConversion` |
| `interfaces` | op trait、op 接口（`OpInterfaces`）、`BranchOpInterface` / `RegionBranchOpInterface`、内存效应、符号和符号表 | `mlir/Interfaces`、`SymbolTable` |
| `layout` | `MemrefLayout`（步长、偏移）、`DataLayout`（类型尺寸、对齐、index 位宽） | `BuiltinTypes`、`DataLayoutInterfaces` |
| `patterns` | ⭐ 规则集，每个源方言一个目录：`<d>/canonicalize.rs`（折叠、常量物化和规范化模式，`<D>Canon`）、`<d>/to_<target>.rs`（`scf/to_cf.rs`、`arith/to_llvm.rs`），以及它自己的变换规则 | `*Ops.cpp`、`mlir/lib/Conversion`、`Dialect/*/Transforms` |
| `passes` | ⭐ 流水线单元，每个源方言一个目录、每个 pass 一个文件（`scf/convert_scf_to_cf.rs`、`linalg/linalg_fold_unit_extent_dims.rs`）；`transforms/` 放和方言无关的 | `mlir/lib/Conversion`、`Dialect/*/Transforms`、`mlir/lib/Transforms` |
| `dialects` | 各上游方言的 `OpInterfaces`，每个一个单元结构体（`ScfDialect`……） | `mlir/lib/Dialect/*/IR` |
| `targets` | `Emit` trait，以及各后端共用的东西（类型转换器、`convert-to-*` 接口、SPIR-V 二进制、GLSL 源码、CPU target 生成的指令选择）；`Stencils` 快路径：模板函数只走一次管线和后端的 `StencilEmit`，之后 JIT 只拷贝机器码、填空位（`Abs64` / `Disp32` / `Rel32` / `Branch26`） | `mlir-translate` |

## Features

缺省构建带全部上游方言和上游后端（`all-dialects`、`all-targets`）。使用方只编自己要跑的，例如
`default-features = false, features = ["std", "dialect.scf", "dialect.arith", "target.llvm"]`。

- `dialect.<name>`：一个方言的 op 接口、折叠、规范化模式、它自己的变换，以及它到别的方言的下降
  （`dialects/<name>.rs`、`patterns/<name>/`、`passes/<name>/`）。代码用到别的方言时会打开那个方言。
  不开某个方言的 feature，它的 op 照样能解析和打印（mlirformat 都认识），只是对折叠和模式不透明。
- `target.<backend>`：一个后端。它的规则和 pass 和别的一样放在 `patterns/` / `passes/`（`arith/to_llvm.rs`
  需要 `dialect.arith` 和 `target.llvm`）；`src/targets` 放它们共用的东西。
- GLSL 源码方言（`dialect.glsl`）不在 `all-dialects` 里；`target.glsl` 会打开它。

每个 feature 的说明、缺省与否、编进来的 pass，见 [README.md 的 feature 表](README.md#features)（由
`scripts/features.py` 从 `Cargo.toml` 和 `src/registry.gen.rs` 生成）。

## 声明 pass 和下降

pass 和模式集用 `mlirpass-macros`（`macros/`）的过程宏声明，由 mlirpass 重导出
（`use mlirpass::{pass, patterns, ops, blocks};`，crate 内部 `use crate::pass;`），⛔ 手写展开：

```rust
/// 带选项的 pass：它的字段是 `Passes.td` 里的选项。
#[pass("convert-complex-to-llvm")]
pub struct ConvertComplexToLlvm {
    #[opt("complex-range", default = ComplexRange::Basic, from_str)]
    range: ComplexRange,
}

impl Run for ConvertComplexToLlvm {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> { /* ... */ }
}

/// 不带选项的 pass：函数就是它的 `run`，结构体 `Sccp` 是生成的。
#[pass("sccp")]
pub fn sccp<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> { /* ... */ }

/// 转换模式：每个 `#[convert]` 方法进入生成的 `populate`。
#[patterns(converter, improved: bool)]
impl ComplexToLlvm {
    #[convert("complex.add", "complex.sub")]
    fn arith(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool { /* ... */ }

    #[convert("complex.div", when = improved)]
    fn div_improved(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool { /* ... */ }
}
```

只有目标不同的行，在同一个 `impl` 上用 `#[map]` 整体生成：

```rust
#[patterns(converter)]
#[map("arith.addf" => "llvm.fadd", fastmath, fp)]            // 一对一改写本身
#[map("arith.shli" => "emitc.bitwise_left_shift", via = Self::shift(true))] // 一族的模板
impl ArithToLlvm { /* 特殊情况，写成 #[convert] 方法 */ }
```

算术就写成算术：`#[ops(b, fmf = f)]` 把 `+ - * / & | ^ << >>`、一元 `-` 和浮点字面量变成经 `b` 构建的 op，
顺序和 C++ 的创建顺序一致。配合 `#[patterns(builder = ctor)]`，`#[convert]` 由签名声明：操作数、从 op 上读出的
属性、作为返回值的替换。

```rust
#[convert("complex.mul")]
#[ops(b, fmf = fmf)]
fn mul(b: &mut Cx<'_, '_, '_, '_>, l: ValueId, r: ValueId, fmf: Fmf) -> ValueId {
    let (lr, li, rr, ri) = (b.re(l), b.im(l), b.re(r), b.im(r));
    let re = lr * rr - li * ri;
    let im = li * rr + lr * ri;
    b.create(re, im)
}
```

控制流用 `blocks!` 按最终顺序写出它的块：

```rust
blocks!(f;
    entry(base: t.clone(), power: t.clone()) { f.cond_br(f.cmpi(EQ, power, zero), done, &[], body, &[]); }
    body { f.br(done, &[base * base]); }
    done(r: t.clone()) { f.ret(&[r]); }
);
```

各宏的参数：
- `#[pass("name", on = "op", extra = [..], check = path)]`：`mlir-opt` 里的名字、锚定 op、接受但不用的选项、
  校验钩子。对 `fn` 形式的 pass，`ty = Name` 指定生成的结构体名（缺省是名字的驼峰形式）。
- `#[patterns]`：`converter`（类型转换器序号）、`options = T`（方法也接收选项）、`extra = path`（不是方法的
  模式），以及 `flag: T` 参数。
- `#[convert]`：根 op（`_` 表示任意 op）、`benefit`、`when`、`untyped`、`plain`。

改写模式写成 `#[patterns]` impl 里的 `#[rewrite]` 方法，用于同方言内的改写：规范化、某个变换的规则。
- 每个方法变成一个实现 `Pattern` 的单元结构体。名字取方法名的驼峰形式，或用 `name = ".."` 指定。
- 结构体带上它的根 op 和 benefit。根 op 可以是 `_`（任意 op），用于 `EraseDeadLinalgOp` 这类接口模式。
- 生成的 `patterns(set)` 按顺序把它们全部加入；`populate` 也把它们作为转换模式加入。

```rust
#[patterns]
impl TensorCanon {
    /// `FoldFillWithTensorExtract`：fill 的元素就是 fill 的值。
    #[rewrite("tensor.extract")]
    fn fold_fill_with_tensor_extract(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let Some(f) = rw.body.def_named(rw.body[op].operands[0], "linalg.fill") else { return false };
        let v = rw.body[f].operands[0];
        rw.replace_op(op, &[v]);
        true
    }
}
```

`mem2reg` / `sroa` 把内存槽接口（`src/passes/transforms/memslot.rs`）当作 trait 来询问：`Promotable` 和
`Destructurable`。方言按 op 名为自己的 op 实现一次，实现在单元结构体 `LlvmSlots` 和 `MemrefSlots` 上。

线程：
- `Body` 由 arena 组成，每个函数一个（`Seg`；id 是 `(seg, index)`），所以函数能不拷贝地移到线程上再移回来
  （`Body::lend`）。
- 用到线程的地方：
  - 读入（`Body::parse_in`）、导入、打印（`Body::show_in`）、嵌套流水线；
  - 到 LLVM 的各转换和 `convert-scf-to-cf`（`#[pass(.., local)]`）：逐个函数处理，进入模块的东西按串行顺序
    合并回来；
  - `sccp` 和 `remove-dead-values`：数据流按函数求解，每轮交换各可调用体的调用者和返回值。
- 输出和串行的结果逐字节相同。

嵌套流水线并行执行：`PassManager::run_on(body, op, &ThreadMulti::default())` 把嵌套流水线里每个
`IsolatedFromAbove` 的 op（`llvm.func(...)`、`func.func(...)`）移进它自己的 body，作为线程池的任务运行；结果和
单线程一样（`-mlir-disable-threading` 对应 `ThreadMulti::from(1)`，不启动线程）。`run_on`、`Body::parse_in`、
`Body::show_in` 接收任意 moremath `Executor`：一个池负责读入、导入、运行和打印。`PassManager::run` 在第一次调用时
建好线程池并留着，之后再调不再起线程；一次只编一个函数的调用方（如 JIT）应给 `run_on` 传 moremath 的
`ThreadSingle`。命令行缺省开线程，和 `mlir-opt` 一样。

没有任何全局状态。
- 流水线通过 `PassRegistry` 找 pass（`Invocation::parse(&passes, args)`）。pass 由函数注册，用 `Passes::with`
  串起来：`Passes::new().with(Passes::add_upstream).with(my_passes)`。
- `Passes::add_upstream`（单独用就是 `Passes::upstream()`）注册编进来的全部 pass。它就是 `src/registry.gen.rs`：
  - 由 `scripts/registry.py` 从 `src/` 下的 `#[pass]` 生成；
  - 每个 pass 带着通向它的那些 `mod` 的 `cfg`；
  - 加了 pass 后要重跑它，`--check` 在过期时失败。
- `Body` 通过它的 `Ctx` 了解 op，所以核心代码不点名任何方言的 op
  （`Body::parse(Ctx::new(&opt, &Interfaces::upstream()), src)`）。`Ctx` 里有两样：
  - mlirformat 的 `MlirOpt`：装载的方言、ODS 的表；
  - 存放各方言 `OpInterfaces` 的 `Interfaces`：上游在 C++ 里算的东西，包括效应、可推测性、分支和区域分支的后继、
    调用。
- `convert-to-llvm` / `convert-to-emitc` 询问它们持有的 `DialectInterfaces`：哪些方言有接口、各自加什么。

## CPU 机器码

`target.x86_64` 和 `target.aarch64` 把 llvm 方言变成机器码，做法和 LLVM 的快速指令选择器（`-O0` 和 LLVM 的 JIT
用的那个）一样，一次一个 op：

- `scripts/isel.py` 从 llvm-project 23.1.5 的 TableGen 生成 `src/targets/{x86_64,aarch64}/isel.gen.rs`：
  `llvm-tblgen -gen-fast-isel` 给出的模式（单个节点、寄存器和立即数操作数、值类型、立即数谓词、选中的指令，
  按 x86-64 v1 / Armv8-A 取），以及 `--dump-json` 里这些指令和手写部分用到的指令：操作数、绑定操作数、隐式寄存器、
  编码；寄存器类、C 调用约定（`CallingConv.td`）、被调用者保存寄存器，和 `AArch64ExpandPseudo` 展开成真指令的伪指令。
  `--check` 在生成物过期时报错。

  ```sh
  python3 scripts/isel.py --llvm $LLVM          # llvm-tblgen 取 $LLVM/build/bin，或 --tblgen 指定
  ```

- `X86FastISel.cpp` / `AArch64FastISel.cpp` 手写的部分在 `src/targets/{x86_64,aarch64}/mod.rs`：读写内存、比较、
  分支、select、调用、除法；编码照 LLVM（`X86MCCodeEmitter` 的传统编码路径、AArch64 的 `Inst` 位和操作数编码函数），
  由表驱动。
- 值放在寄存器（线性扫描）或帧槽；带 `stencil` 属性的函数是 JIT 的模板（`Stencils`，帧槽、常量、跳转三种空位）。
- `tests/machine_code.rs`：选择器会发的每条指令编码后，用 `llvm-mc` 反汇编必须是同一条 LLVM 指令；函数和拼好的
  模板在本机真跑。AArch64 那一半在 x86-64 上用 qemu 跑：

  ```sh
  CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER=aarch64-linux-gnu-gcc \
  CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_RUNNER="qemu-aarch64-static -L /usr/aarch64-linux-gnu" \
  cargo test --target aarch64-unknown-linux-gnu --test machine_code
  ```

## Fixtures

`tests/fixtures/` 存放 `mlir-opt` 23.1.5 自己的输出，测试因此不需要 LLVM。
- 来源：llvm-project 的 `mlir/test/Conversion`、`mlir/test/Transforms`，以及各方言的 `canonicalize*.mlir`、
  `mem2reg*.mlir`、`sroa*.mlir`。
- 每条 `RUN:` 行一份。

用原版 23.1.5 构建重新生成：

```sh
python3 scripts/fixtures.py --llvm $LLVM --mlir-opt $LLVM_BUILD/bin/mlir-opt
```

## 模糊测试

`fuzz/`（独立 crate）生成随机的合法 IR，同时跑 mlirpass 和 `mlir-opt` 23.1.5（`MLIR_OPT`），保存每个不完全
一致的用例；也在大模块上给两者计时（`fuzz/README.md`）。

## 性能

用 0.8.1 对比 `mlir-opt` 22.1.8 在一个 54 MB 模块上测得（见 `BENCHMARK.md`）。条件：16 个 CPU，两边都开多线程，
jemalloc（命令行的全局分配器）。
- 按完整进程比，每条流水线快 4.1–4.9 倍：
  - canonicalize + cse：430 ms 对 1,790 ms；
  - `-to-llvm` 流水线：1,160 ms 对 5,690 ms；
  - 输入是自定义形式文本时快 2.8–3.0 倍。
- 进程内的解析 + pass + 打印快 8.3–10.7 倍，其中 `-to-llvm` 流水线快 4.5 倍。
- 峰值内存是 `mlir-opt` 的 2.7–3.6 倍（sccp 为 1.2 倍）。

## 许可

MIT
