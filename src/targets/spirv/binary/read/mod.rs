mod cfg;

use alloc::boxed::Box;
use alloc::collections::{BTreeMap, BTreeSet};
use alloc::format;
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::spirv_types::{SpirvDecoration, SpirvMember, SpirvType};
use mlirformat::{ApFloat, ApInt, Attribute, Const, Error, FloatKind, FunctionType, MlirOpt, Operation, Scalar, Signedness, Type};

use super::{Arg, AttrKind, EnumSpec, Group, OpSpec};
use crate::targets::tree::{At, B, O, Tree, V};

/// SPIR-V words ⇒ a `spirv.module` in generic form, as `mlir-translate --deserialize-spirv`
/// (LLVM 23.1.5) builds it
#[derive(Debug, Clone, Copy)]
pub struct SpirvReader {
    /// Put selections and loops into `spirv.mlir.selection` / `spirv.mlir.loop` (the default).
    /// Without it a function stays a plain graph of blocks, as with
    /// `--spirv-structurize-control-flow=false`: that reads what structurization cannot, such as
    /// a loop left early (`break` / `return` inside it).
    pub structurize: bool,
}

impl SpirvReader {
    /// Whether `bytes` are SPIR-V (its magic number)
    pub fn recognizes(bytes: &[u8]) -> bool {
        bytes.get(..Reader::WORD).is_some_and(|m| u32::from_le_bytes([m[0], m[1], m[2], m[3]]) == SpirvReader::MAGIC)
    }
}

impl Default for SpirvReader {
    fn default() -> Self {
        Self { structurize: true }
    }
}

impl SpirvReader {
    /// The format's name
    pub const NAME: &'static str = "spirv";
    /// The first word of a SPIR-V module
    pub const MAGIC: u32 = 0x0723_0203;

    pub fn read(&self, bytes: &[u8]) -> Result<Operation<'static>, Error> {
        self.read_in(bytes, &MlirOpt::upstream())
    }

    /// `bytes` read with `opt`'s op infos (which attributes are inherent), so that none is built for each module
    pub fn read_in(&self, bytes: &[u8], opt: &MlirOpt) -> Result<Operation<'static>, Error> {
        if !bytes.len().is_multiple_of(Reader::WORD) {
            return Err(Error(format!("{} bytes are not whole SPIR-V words", bytes.len())));
        }
        let words: Vec<u32> = bytes.as_chunks::<{ Reader::WORD }>().0.iter().map(|w| u32::from_le_bytes(*w)).collect();
        let mut r = Reader::new(&words);
        r.structurize = self.structurize;
        r.read()?;
        r.expand_all();
        Ok(r.tree.operation(r.module, opt))
    }
}

/// The opcodes the reader handles itself; every other one is an op of the grammar tables
struct Opcode;

impl Opcode {
    const UNDEF: u32 = 1;
    const SOURCE_CONTINUED: u32 = 2;
    const SOURCE: u32 = 3;
    const SOURCE_EXTENSION: u32 = 4;
    const NAME: u32 = 5;
    const MEMBER_NAME: u32 = 6;
    const STRING: u32 = 7;
    const LINE: u32 = 8;
    const EXTENSION: u32 = 10;
    const EXT_INST_IMPORT: u32 = 11;
    const EXT_INST: u32 = 12;
    const MEMORY_MODEL: u32 = 14;
    const ENTRY_POINT: u32 = 15;
    const EXECUTION_MODE: u32 = 16;
    const CAPABILITY: u32 = 17;
    const TYPE_VOID: u32 = 19;
    const TYPE_BOOL: u32 = 20;
    const TYPE_INT: u32 = 21;
    const TYPE_FLOAT: u32 = 22;
    const TYPE_VECTOR: u32 = 23;
    const TYPE_MATRIX: u32 = 24;
    const TYPE_IMAGE: u32 = 25;
    const TYPE_SAMPLER: u32 = 26;
    const TYPE_SAMPLED_IMAGE: u32 = 27;
    const TYPE_ARRAY: u32 = 28;
    const TYPE_RUNTIME_ARRAY: u32 = 29;
    const TYPE_STRUCT: u32 = 30;
    const TYPE_POINTER: u32 = 32;
    const TYPE_FUNCTION: u32 = 33;
    const TYPE_FORWARD_POINTER: u32 = 39;
    const CONSTANT_TRUE: u32 = 41;
    const CONSTANT_FALSE: u32 = 42;
    const CONSTANT: u32 = 43;
    const CONSTANT_COMPOSITE: u32 = 44;
    const CONSTANT_NULL: u32 = 46;
    const SPEC_CONSTANT_TRUE: u32 = 48;
    const SPEC_CONSTANT_FALSE: u32 = 49;
    const SPEC_CONSTANT: u32 = 50;
    const SPEC_CONSTANT_COMPOSITE: u32 = 51;
    const SPEC_CONSTANT_OP: u32 = 52;
    const FUNCTION: u32 = 54;
    const FUNCTION_PARAMETER: u32 = 55;
    const FUNCTION_END: u32 = 56;
    const FUNCTION_CALL: u32 = 57;
    const VARIABLE: u32 = 59;
    const COPY_MEMORY: u32 = 63;
    const DECORATE: u32 = 71;
    const MEMBER_DECORATE: u32 = 72;
    const GENERIC_CAST_TO_PTR_EXPLICIT: u32 = 123;
    const PHI: u32 = 245;
    const LOOP_MERGE: u32 = 246;
    const SELECTION_MERGE: u32 = 247;
    const LABEL: u32 = 248;
    const BRANCH: u32 = 249;
    const BRANCH_CONDITIONAL: u32 = 250;
    const SWITCH: u32 = 251;
    const NO_LINE: u32 = 317;
    const TYPE_NAMED_BARRIER: u32 = 327;
    const MODULE_PROCESSED: u32 = 330;
    const EXECUTION_MODE_ID: u32 = 331;
    const DECORATE_ID: u32 = 332;
    const TYPE_COOPERATIVE_MATRIX_KHR: u32 = 4456;
    const CONSTANT_COMPOSITE_REPLICATE_EXT: u32 = 4461;
    const SPEC_CONSTANT_COMPOSITE_REPLICATE_EXT: u32 = 4462;
    const TYPE_TENSOR_ARM: u32 = 4163;
    const GRAPH_CONSTANT_ARM: u32 = 4181;
    const GRAPH_ENTRY_POINT_ARM: u32 = 4182;
    const GRAPH_ARM: u32 = 4183;
    const GRAPH_INPUT_ARM: u32 = 4184;
    const GRAPH_SET_OUTPUT_ARM: u32 = 4185;
    const GRAPH_END_ARM: u32 = 4186;
    const TYPE_GRAPH_ARM: u32 = 4190;
}

/// Decorations by their SPIR-V number
struct Deco;

impl Deco {
    const RELAXED_PRECISION: u32 = 0;
    const SPEC_ID: u32 = 1;
    const BLOCK: u32 = 2;
    const BUFFER_BLOCK: u32 = 3;
    const ARRAY_STRIDE: u32 = 6;
    const BUILT_IN: u32 = 11;
    const NO_PERSPECTIVE: u32 = 13;
    const FLAT: u32 = 14;
    const PATCH: u32 = 15;
    const INVARIANT: u32 = 18;
    const RESTRICT: u32 = 19;
    const ALIASED: u32 = 20;
    const CONSTANT: u32 = 22;
    const COHERENT: u32 = 23;
    const NON_WRITABLE: u32 = 24;
    const NON_READABLE: u32 = 25;
    const LOCATION: u32 = 30;
    const INDEX: u32 = 32;
    const BINDING: u32 = 33;
    const DESCRIPTOR_SET: u32 = 34;
    const OFFSET: u32 = 35;
    const XFB_BUFFER: u32 = 36;
    const XFB_STRIDE: u32 = 37;
    const FP_ROUNDING_MODE: u32 = 39;
    const FP_FAST_MATH_MODE: u32 = 40;
    const LINKAGE_ATTRIBUTES: u32 = 41;
    const NO_CONTRACTION: u32 = 42;
    const ALIGNMENT_ID: u32 = 46;
    const MAX_BYTE_OFFSET_ID: u32 = 47;
    const NO_SIGNED_WRAP: u32 = 4469;
    const NO_UNSIGNED_WRAP: u32 = 4470;
    const RESTRICT_POINTER: u32 = 5355;
    const ALIASED_POINTER: u32 = 5356;
    const COUNTER_BUFFER: u32 = 5634;
    const CACHE_CONTROL_LOAD_INTEL: u32 = 6442;
    const CACHE_CONTROL_STORE_INTEL: u32 = 6443;

    /// Decorations that are a unit attribute
    const UNIT: &'static [u32] = &[
        Deco::ALIASED,
        Deco::ALIASED_POINTER,
        Deco::BLOCK,
        Deco::BUFFER_BLOCK,
        Deco::FLAT,
        Deco::NON_READABLE,
        Deco::NON_WRITABLE,
        Deco::NO_PERSPECTIVE,
        Deco::NO_SIGNED_WRAP,
        Deco::NO_UNSIGNED_WRAP,
        Deco::RELAXED_PRECISION,
        Deco::RESTRICT,
        Deco::RESTRICT_POINTER,
        Deco::NO_CONTRACTION,
        Deco::CONSTANT,
        Deco::INVARIANT,
        Deco::PATCH,
        Deco::COHERENT,
    ];

    /// Decorations that are one 32-bit integer
    const INTEGER: &'static [u32] = &[Deco::DESCRIPTOR_SET, Deco::BINDING, Deco::LOCATION, Deco::SPEC_ID, Deco::INDEX, Deco::OFFSET, Deco::XFB_BUFFER, Deco::XFB_STRIDE];

    /// What a function argument may carry, as a `spirv.decoration`
    const ARGUMENT: &'static [u32] = &[Deco::ALIASED, Deco::RESTRICT, Deco::ALIASED_POINTER, Deco::RESTRICT_POINTER];

    fn name(code: u32) -> Option<&'static str> {
        EnumSpec::of(Reader::DECORATION)?.cases_of(code).first().map(|c| c.name)
    }
}

/// `OpTypeFloat`'s encodings
struct Encoding;

impl Encoding {
    const BFLOAT16_KHR: u32 = 0;
    const FLOAT8_E4M3_EXT: u32 = 4214;
    const FLOAT8_E5M2_EXT: u32 = 4215;
}

/// A struct's member decorations: by member, each decoration's number and literals
type MemberDecorations = BTreeMap<u32, Vec<(u32, Vec<u32>)>>;

/// Where a selection or a loop merges (`OpSelectionMerge` / `OpLoopMerge`)
#[derive(Clone, Copy)]
struct Merge {
    control: u32,
    merge: B,
    /// A loop's continue target
    cont: Option<B>,
}

/// One struct type's parts, kept until its forward-declared pointer members are known
struct PendingStruct {
    id: u32,
    unresolved: Vec<(u32, usize)>,
    members: Vec<Option<Type<'static>>>,
}

pub struct Reader<'w> {
    words: &'w [u32],
    offset: usize,
    tree: Tree,
    module: O,
    module_block: B,
    version: u32,
    capabilities: Vec<u32>,
    extensions: Vec<String>,
    ext_sets: BTreeMap<u32, String>,
    names: BTreeMap<u32, String>,
    types: BTreeMap<u32, Type<'static>>,
    voids: BTreeSet<u32>,
    strides: BTreeMap<u32, u32>,
    decorations: BTreeMap<u32, Vec<(String, Attribute<'static>)>>,
    member_decorations: BTreeMap<u32, MemberDecorations>,
    forward_pointers: BTreeSet<u32>,
    pending_structs: Vec<PendingStruct>,
    /// Identified structs' bodies by name: MLIR uniques them, so a body set later is what
    /// every earlier reference sees
    identified: BTreeMap<String, Type<'static>>,
    constants: BTreeMap<u32, (Attribute<'static>, Type<'static>)>,
    replicates: BTreeMap<u32, (Attribute<'static>, Type<'static>)>,
    /// Spec constants (and composites of them) by <id>: their symbol and type
    specs: BTreeMap<u32, (String, Type<'static>)>,
    spec_ops: BTreeMap<u32, (u32, u32, Vec<u32>)>,
    undefs: BTreeMap<u32, Type<'static>>,
    globals: BTreeMap<u32, (String, Type<'static>)>,
    funcs: BTreeMap<u32, (O, String)>,
    values: BTreeMap<u32, V>,
    block_ids: BTreeMap<u32, B>,
    merges: Vec<(B, Merge)>,
    phis: Vec<((B, B), Vec<u32>)>,
    func: Option<O>,
    block: Option<B>,
    /// ARM graph constants: their type and `graph_constant_id`
    graph_constants: BTreeMap<u32, (Type<'static>, i64)>,
    graphs: BTreeMap<u32, O>,
    outputs: Vec<Option<V>>,
    /// Each constant's scalars as MLIR prints them, in row-major order (dense tensors)
    literals: BTreeMap<u32, Vec<String>>,
    deferred: Vec<(u32, Vec<u32>)>,
    id_decorations: Vec<(u32, u32, u32)>,
    structurize: bool,
}

impl<'w> Reader<'w> {
    const WORD: usize = 4;
    const HEADER: usize = 5;
    const MAGIC: u32 = 0x0723_0203;
    const MAJOR: u32 = 1;
    const LONG_WORD: u32 = 64;
    const WORD_BITS: u32 = 32;
    const DECORATION: &'static str = "Decoration";
    pub const CASE_SEGMENTS: &'static str = "case_operand_segments";
    const SEGMENTS: &'static str = "operandSegmentSizes";
    const SIGNED: u32 = 1;
    const MAX_MINOR: u32 = 6;
    /// The extended instruction set of graph debug info: locations only, not printed
    const GRAPH_DEBUG_INFO: &'static str = "NonSemantic.Graph.DebugInfo.1";

    fn new(words: &'w [u32]) -> Self {
        let mut tree = Tree::new();
        let module = tree.create("spirv.module", &[], &[], Vec::new(), &[], 1);
        let r = tree.node(module).regions[0];
        let module_block = tree.block_in(r);
        tree.at = Some(At::End(module_block));
        Reader {
            words,
            offset: Reader::HEADER,
            tree,
            module,
            module_block,
            version: 0,
            capabilities: Vec::new(),
            extensions: Vec::new(),
            ext_sets: BTreeMap::new(),
            names: BTreeMap::new(),
            types: BTreeMap::new(),
            voids: BTreeSet::new(),
            strides: BTreeMap::new(),
            decorations: BTreeMap::new(),
            member_decorations: BTreeMap::new(),
            forward_pointers: BTreeSet::new(),
            pending_structs: Vec::new(),
            identified: BTreeMap::new(),
            constants: BTreeMap::new(),
            replicates: BTreeMap::new(),
            specs: BTreeMap::new(),
            spec_ops: BTreeMap::new(),
            undefs: BTreeMap::new(),
            globals: BTreeMap::new(),
            funcs: BTreeMap::new(),
            values: BTreeMap::new(),
            block_ids: BTreeMap::new(),
            merges: Vec::new(),
            phis: Vec::new(),
            func: None,
            block: None,
            graph_constants: BTreeMap::new(),
            graphs: BTreeMap::new(),
            outputs: Vec::new(),
            literals: BTreeMap::new(),
            deferred: Vec::new(),
            id_decorations: Vec::new(),
            structurize: true,
        }
    }

    fn err<T>(msg: impl Into<String>) -> Result<T, Error> {
        Err(Error(msg.into()))
    }

    fn read(&mut self) -> Result<(), Error> {
        let w = self.words;
        if w.len() < Reader::HEADER {
            return Reader::err("SPIR-V binary module must have a 5-word header");
        }
        if w[0] != Reader::MAGIC {
            return Reader::err("incorrect magic number");
        }
        let (major, minor) = ((w[1] >> 16) & 0xff, (w[1] >> 8) & 0xff);
        if major != Reader::MAJOR || minor > Reader::MAX_MINOR {
            return Reader::err(format!("unsupported SPIR-V version: {major}.{minor}"));
        }
        self.version = minor;
        while self.offset < w.len() {
            let (op, operands) = self.slice()?;
            self.instruction(op, &operands, true)?;
        }
        for (op, operands) in core::mem::take(&mut self.deferred) {
            self.instruction(op, &operands, false)?;
        }
        self.resolve_id_decorations()?;
        self.attach_vce();
        Ok(())
    }

    /// The next instruction's opcode and operands
    fn slice(&mut self) -> Result<(u32, Vec<u32>), Error> {
        let w = self.words;
        let Some(first) = w.get(self.offset) else { return Reader::err("expected more instruction") };
        let count = (first >> 16) as usize;
        if count == 0 {
            return Reader::err("word count cannot be zero");
        }
        if self.offset + count > w.len() {
            return Reader::err("insufficient words for the last instruction");
        }
        let out = (first & 0xffff, w[self.offset + 1..self.offset + count].to_vec());
        self.offset += count;
        Ok(out)
    }

    fn string(words: &[u32], at: &mut usize) -> String {
        let mut bytes = Vec::new();
        'words: while let Some(w) = words.get(*at) {
            *at += 1;
            for b in w.to_le_bytes() {
                if b == 0 {
                    break 'words;
                }
                bytes.push(b);
            }
        }
        String::from_utf8_lossy(&bytes).into_owned()
    }

    fn instruction(&mut self, op: u32, w: &[u32], defer: bool) -> Result<(), Error> {
        match op {
            Opcode::CAPABILITY => self.capabilities.push(*w.first().ok_or_else(|| Error::from("OpCapability must have one parameter"))?),
            Opcode::EXTENSION => {
                let s = Reader::string(w, &mut 0);
                if !self.extensions.contains(&s) {
                    self.extensions.push(s);
                }
            }
            Opcode::EXT_INST_IMPORT => {
                let name = Reader::string(w, &mut 1);
                self.ext_sets.insert(w[0], name);
            }
            Opcode::EXT_INST if self.ext_sets.get(&w[2]).is_some_and(|s| s == Reader::GRAPH_DEBUG_INFO) => {}
            Opcode::EXT_INST => return self.ext_inst(w),
            Opcode::TYPE_TENSOR_ARM | Opcode::TYPE_GRAPH_ARM => return self.ty(op, w),
            Opcode::GRAPH_CONSTANT_ARM => {
                let t = self.get_type(w[0])?;
                self.graph_constants.insert(w[1], (t, i64::from(w[2] as i32)));
            }
            Opcode::GRAPH_ENTRY_POINT_ARM if defer => self.deferred.push((op, w.to_vec())),
            Opcode::GRAPH_ENTRY_POINT_ARM => return self.graph_entry_point(w),
            Opcode::GRAPH_ARM => return self.graph(w),
            Opcode::GRAPH_SET_OUTPUT_ARM => {
                let v = self.value(w[0])?;
                let i = self.int_constant(w[1])? as usize;
                if i >= self.outputs.len() {
                    self.outputs.resize(i + 1, None);
                }
                self.outputs[i] = Some(v);
            }
            Opcode::GRAPH_END_ARM => {
                let outs = core::mem::take(&mut self.outputs).into_iter().map(|o| o.ok_or_else(|| Error::from("a graph output never set"))).collect::<Result<Vec<_>, _>>()?;
                self.tree.create("spirv.ARM.GraphOutputs", &outs, &[], Vec::new(), &[], 0);
                self.func = None;
                self.block = None;
                self.block_ids.clear();
                self.tree.at = Some(At::End(self.module_block));
            }
            Opcode::MEMBER_NAME | Opcode::SOURCE | Opcode::SOURCE_CONTINUED | Opcode::SOURCE_EXTENSION | Opcode::MODULE_PROCESSED | Opcode::STRING | Opcode::LINE | Opcode::NO_LINE => {}
            Opcode::MEMORY_MODEL => {
                let m = self.module;
                let a = Reader::enum_attr("AddressingModel", w[0])?;
                let b = Reader::enum_attr("MemoryModel", w[1])?;
                self.tree.node_mut(m).set("addressing_model", a);
                self.tree.node_mut(m).set("memory_model", b);
            }
            Opcode::ENTRY_POINT | Opcode::EXECUTION_MODE | Opcode::EXECUTION_MODE_ID if defer => self.deferred.push((op, w.to_vec())),
            Opcode::ENTRY_POINT => return self.entry_point(w),
            Opcode::EXECUTION_MODE | Opcode::EXECUTION_MODE_ID => return self.execution_mode(w, op == Opcode::EXECUTION_MODE_ID),
            Opcode::VARIABLE if self.func.is_none() => return self.global_variable(w),
            Opcode::NAME => {
                let name = Reader::string(w, &mut 1);
                self.names.insert(w[0], name);
            }
            Opcode::TYPE_VOID
            | Opcode::TYPE_BOOL
            | Opcode::TYPE_INT
            | Opcode::TYPE_FLOAT
            | Opcode::TYPE_VECTOR
            | Opcode::TYPE_MATRIX
            | Opcode::TYPE_ARRAY
            | Opcode::TYPE_FUNCTION
            | Opcode::TYPE_IMAGE
            | Opcode::TYPE_SAMPLER
            | Opcode::TYPE_NAMED_BARRIER
            | Opcode::TYPE_SAMPLED_IMAGE
            | Opcode::TYPE_RUNTIME_ARRAY
            | Opcode::TYPE_STRUCT
            | Opcode::TYPE_POINTER
            | Opcode::TYPE_COOPERATIVE_MATRIX_KHR => return self.ty(op, w),
            Opcode::TYPE_FORWARD_POINTER => {
                self.forward_pointers.insert(w[0]);
            }
            Opcode::CONSTANT => return self.constant(w, false),
            Opcode::SPEC_CONSTANT => return self.constant(w, true),
            Opcode::CONSTANT_COMPOSITE => return self.constant_composite(w),
            Opcode::CONSTANT_COMPOSITE_REPLICATE_EXT => {
                let ty = self.get_type(w[0])?;
                let c = self.constants.get(&w[2]).or_else(|| self.replicates.get(&w[2])).ok_or_else(|| Error::from("OpConstantCompositeReplicateEXT operand must come from a normal constant"))?;
                let value = c.0.clone();
                self.replicates.insert(w[1], (value, ty));
            }
            Opcode::SPEC_CONSTANT_COMPOSITE => return self.spec_composite(w),
            Opcode::SPEC_CONSTANT_COMPOSITE_REPLICATE_EXT => return self.spec_replicate(w),
            Opcode::SPEC_CONSTANT_OP => {
                self.spec_ops.insert(w[1], (w[2], w[0], w[3..].to_vec()));
            }
            Opcode::CONSTANT_TRUE | Opcode::CONSTANT_FALSE => {
                let b = op == Opcode::CONSTANT_TRUE;
                self.literals.insert(w[1], vec![format!("{b}")]);
                self.constants.insert(w[1], (Attribute::Bool(b), Type::I1));
            }
            Opcode::SPEC_CONSTANT_TRUE | Opcode::SPEC_CONSTANT_FALSE => self.spec_constant(w[1], Attribute::Bool(op == Opcode::SPEC_CONSTANT_TRUE), Type::I1),
            Opcode::CONSTANT_NULL => return self.constant_null(w),
            Opcode::DECORATE | Opcode::DECORATE_ID => return self.decoration(w),
            Opcode::MEMBER_DECORATE => {
                self.member_decorations.entry(w[0]).or_default().entry(w[1]).or_default().push((w[2], w[3..].to_vec()));
            }
            Opcode::FUNCTION => return self.function(w),
            Opcode::LABEL => {
                let b = self.get_block(w[0]);
                self.tree.start(b);
                self.block = Some(b);
            }
            Opcode::BRANCH => {
                let t = self.get_block(w[0]);
                self.tree.create("spirv.Branch", &[], &[], Vec::new(), &[t], 0);
            }
            Opcode::BRANCH_CONDITIONAL => return self.branch_conditional(w),
            Opcode::SELECTION_MERGE => {
                let merge = self.get_block(w[0]);
                let b = self.block.ok_or_else(|| Error::from("OpSelectionMerge must appear in a block"))?;
                self.merges.push((b, Merge { control: w[1], merge, cont: None }));
            }
            Opcode::LOOP_MERGE => {
                let merge = self.get_block(w[0]);
                let cont = self.get_block(w[1]);
                let b = self.block.ok_or_else(|| Error::from("OpLoopMerge must appear in a block"))?;
                self.merges.push((b, Merge { control: w[2], merge, cont: Some(cont) }));
            }
            Opcode::PHI => return self.phi(w),
            Opcode::SWITCH => return self.switch(w),
            Opcode::UNDEF => {
                let ty = self.get_type(w[0])?;
                self.undefs.insert(w[1], ty);
            }
            _ => return self.autogen(op, w),
        }
        Ok(())
    }

    fn attach_vce(&mut self) {
        let caps: Vec<String> = self.capabilities.iter().filter_map(|c| EnumSpec::of("Capability")?.cases_of(*c).first().map(|x| String::from(x.name))).collect();
        let text = format!("v1.{}, [{}], [{}]", self.version, caps.join(", "), self.extensions.join(", "));
        let m = self.module;
        self.tree.node_mut(m).set("vce_triple", Attribute::dialect_with("spirv.vce", text));
    }

    /// `#spirv.<mnemonic><Case>` of enum `class`
    fn enum_attr(class: &str, value: u32) -> Result<Attribute<'static>, Error> {
        let spec = EnumSpec::of(class).ok_or_else(|| Error(format!("no enum {class}")))?;
        let text = spec.text(value).ok_or_else(|| Error(format!("{value} is no {class}")))?;
        let mnemonic = EnumSpec::mnemonic(class).ok_or_else(|| Error(format!("no attribute for enum {class}")))?;
        Ok(Attribute::dialect_with(&format!("spirv.{mnemonic}"), text))
    }

    // ----- types ---------------------------------------------------------------------------

    fn get_type(&self, id: u32) -> Result<Type<'static>, Error> {
        self.types.get(&id).cloned().ok_or_else(|| Error(format!("undefined type <id> {id}")))
    }

    fn ty(&mut self, op: u32, w: &[u32]) -> Result<(), Error> {
        let id = w[0];
        let t: Type<'static> = match op {
            Opcode::TYPE_VOID => {
                self.voids.insert(id);
                Type::NoneType
            }
            Opcode::TYPE_BOOL => Type::I1,
            Opcode::TYPE_INT => Type::Integer { signedness: if w[2] == Reader::SIGNED { Signedness::Signed } else { Signedness::Signless }, width: w[1] },
            Opcode::TYPE_FLOAT => Type::Float(match (w[1], w.get(2).copied()) {
                (16, None) => FloatKind::F16,
                (32, None) => FloatKind::F32,
                (64, None) => FloatKind::F64,
                (16, Some(Encoding::BFLOAT16_KHR)) => FloatKind::BF16,
                (8, Some(Encoding::FLOAT8_E4M3_EXT)) => FloatKind::F8E4M3FN,
                (8, Some(Encoding::FLOAT8_E5M2_EXT)) => FloatKind::F8E5M2,
                (b, e) => return Reader::err(format!("unsupported OpTypeFloat bitwidth {b} encoding {e:?}")),
            }),
            Opcode::TYPE_VECTOR => Type::vector(&[i64::from(w[2])], &[], self.get_type(w[1])?),
            Opcode::TYPE_MATRIX => SpirvType::Matrix { cols: w[2], column: Box::new(self.get_type(w[1])?) }.into(),
            Opcode::TYPE_ARRAY => {
                let n = self.constants.get(&w[2]).and_then(|(a, _)| Const::try_from(a).ok()?.as_int()).ok_or_else(|| Error::from("OpTypeArray count must come from a scalar integer constant instruction"))?;
                SpirvType::Array { len: n.unsigned() as u32, elem: Box::new(self.get_type(w[1])?), stride: self.strides.get(&id).copied().unwrap_or(0) }.into()
            }
            Opcode::TYPE_RUNTIME_ARRAY => SpirvType::RuntimeArray { elem: Box::new(self.get_type(w[1])?), stride: self.strides.get(&id).copied().unwrap_or(0) }.into(),
            Opcode::TYPE_FUNCTION => {
                let ret = w[1];
                let inputs = w[2..].iter().map(|t| self.get_type(*t)).collect::<Result<Vec<_>, _>>()?;
                let results = if self.voids.contains(&ret) { Vec::new() } else { vec![self.get_type(ret)?] };
                Type::Function(Box::new(FunctionType { inputs, results }))
            }
            Opcode::TYPE_IMAGE => {
                if w.len() != 8 {
                    return Reader::err("OpTypeImage with non-eight operands are not supported yet");
                }
                let classes = ["Dim", "ImageDepthInfo", "ImageArrayedInfo", "ImageSamplingInfo", "ImageSamplerUseInfo", "ImageFormat"];
                let mut params: [String; 6] = Default::default();
                for (i, c) in classes.iter().enumerate() {
                    params[i] = EnumSpec::of(c).and_then(|s| s.text(w[2 + i])).ok_or_else(|| Error(format!("unknown {c} {}", w[2 + i])))?;
                }
                SpirvType::Image { elem: Box::new(self.get_type(w[1])?), params }.into()
            }
            Opcode::TYPE_TENSOR_ARM => {
                let elem = Box::new(self.get_type(w[1])?);
                let shape = match (w.get(2), w.get(3)) {
                    (None, _) => None,
                    (Some(r), None) => Some(vec![-1; self.int_constant(*r)? as usize]),
                    (Some(_), Some(s)) => Some(self.literals.get(s).ok_or_else(|| Error::from("OpTypeTensorARM shape must come from a constant instruction of type OpTypeArray"))?.iter().map(|d| d.parse::<i64>().map_err(|_| Error::from("OpTypeTensorARM shape has an invalid dimension size"))).collect::<Result<Vec<_>, _>>()?),
                };
                SpirvType::TensorArm { shape, elem }.into()
            }
            Opcode::TYPE_GRAPH_ARM => {
                let n = w[1] as usize;
                let all = w[2..].iter().map(|t| self.get_type(*t)).collect::<Result<Vec<_>, _>>()?;
                let (inputs, results) = (all[..n.min(all.len())].to_vec(), all[n.min(all.len())..].to_vec());
                Type::Function(Box::new(FunctionType { inputs, results }))
            }
            Opcode::TYPE_SAMPLER => SpirvType::Sampler.into(),
            Opcode::TYPE_NAMED_BARRIER => SpirvType::NamedBarrier.into(),
            Opcode::TYPE_SAMPLED_IMAGE => SpirvType::SampledImage(Box::new(self.get_type(w[1])?)).into(),
            Opcode::TYPE_POINTER => {
                let storage = EnumSpec::of("StorageClass").and_then(|s| s.text(w[1])).ok_or_else(|| Error(format!("unknown storage class {}", w[1])))?;
                let t: Type<'static> = SpirvType::Ptr { pointee: Box::new(self.get_type(w[2])?), storage }.into();
                self.types.insert(id, t.clone());
                return self.resolve_structs(id, &t);
            }
            Opcode::TYPE_STRUCT => return self.struct_type(w),
            Opcode::TYPE_COOPERATIVE_MATRIX_KHR => {
                let int = |r: &Self, id: u32| r.constants.get(&id).and_then(|(a, _)| Const::try_from(a).ok()?.as_int()).map(|v| v.unsigned() as u32).ok_or_else(|| Error(format!("OpTypeCooperativeMatrixKHR references undefined constant <id> {id}")));
                let scope = EnumSpec::of("Scope").and_then(|s| s.text(int(self, w[2]).ok()?)).ok_or_else(|| Error::from("bad scope"))?;
                let usage = EnumSpec::of("CooperativeMatrixUseKHR").and_then(|s| s.text(int(self, w[5]).ok()?)).ok_or_else(|| Error::from("bad use"))?;
                SpirvType::CoopMatrix { rows: int(self, w[3])?, cols: int(self, w[4])?, elem: Box::new(self.get_type(w[1])?), scope, usage }.into()
            }
            _ => return Reader::err("unhandled type instruction"),
        };
        self.types.insert(id, t);
        Ok(())
    }

    fn snake(camel: &str) -> String {
        let c: Vec<char> = camel.chars().collect();
        let mut out = String::new();
        for i in 0..c.len() {
            out.extend(c[i].to_lowercase());
            let up = |j: usize| c.get(j).is_some_and(|x| x.is_ascii_uppercase());
            let low = |j: usize| c.get(j).is_some_and(|x| x.is_ascii_lowercase());
            let digit = |j: usize| c.get(j).is_some_and(|x| x.is_ascii_digit());
            if (up(i) && up(i + 1) && low(i + 2)) || ((low(i) || digit(i)) && up(i + 1)) {
                out.push('_');
            }
        }
        out
    }

    fn struct_type(&mut self, w: &[u32]) -> Result<(), Error> {
        let id = w[0];
        if w.len() == 1 {
            let name = self.names.get(&id).cloned();
            self.types.insert(id, SpirvType::Struct { name, members: Some(Vec::new()), decorations: Vec::new() }.into());
            return Ok(());
        }
        let mut members = Vec::new();
        let mut unresolved = Vec::new();
        for (i, m) in w[1..].iter().enumerate() {
            match self.types.get(m) {
                Some(t) => members.push(Some(t.clone())),
                None if self.forward_pointers.contains(m) => {
                    unresolved.push((*m, i));
                    members.push(None);
                }
                None => return Reader::err(format!("OpTypeStruct references undefined <id> {m}")),
            }
        }
        if unresolved.is_empty() {
            let t = self.struct_body(id, members.into_iter().map(|m| m.expect("resolved")).collect());
            if let Some(n) = self.names.get(&id) {
                self.identified.insert(n.clone(), t.clone());
            }
            self.types.insert(id, t);
        } else {
            let name = self.names.get(&id).cloned().unwrap_or_default();
            self.types.insert(id, SpirvType::Struct { name: Some(name), members: None, decorations: Vec::new() }.into());
            self.pending_structs.push(PendingStruct { id, unresolved, members });
        }
        Ok(())
    }

    fn struct_body(&self, id: u32, members: Vec<Type<'static>>) -> Type<'static> {
        let all = self.member_decorations.get(&id);
        let any_offset = all.is_some_and(|a| a.values().any(|ds| ds.iter().any(|(d, _)| *d == Deco::OFFSET)));
        let mut out = Vec::new();
        for (i, ty) in members.into_iter().enumerate() {
            let mut offset = any_offset.then_some(0);
            let mut decorations = Vec::new();
            let mut ds = all.and_then(|a| a.get(&(i as u32))).cloned().unwrap_or_default();
            ds.sort_by_key(|(d, _)| *d);
            for (d, ops) in ds {
                if d == Deco::OFFSET {
                    offset = ops.first().copied();
                } else if let Some(name) = Deco::name(d) {
                    decorations.push(SpirvDecoration { name: String::from(name), value: ops.first().map(|v| format!("{v}")) });
                }
            }
            out.push(SpirvMember { ty, offset, decorations });
        }
        let decorations = self
            .decorations
            .get(&id)
            .map(|ds| {
                ds.iter()
                    .map(|(n, a)| {
                        let camel = Reader::camel(n);
                        let value = match a {
                            Attribute::Unit => None,
                            Attribute::Int { lit, .. } => Some(String::from(&**lit)),
                            other => Some(format!("{other}")),
                        };
                        SpirvDecoration { name: camel, value }
                    })
                    .collect()
            })
            .unwrap_or_default();
        let name = self.names.get(&id).cloned();
        SpirvType::Struct { name, members: Some(out), decorations }.into()
    }

    /// `t` with every identified struct it names spelled out, except inside its own body (where
    /// MLIR prints just the name)
    fn expand(&self, t: &Type<'static>, open: &mut Vec<String>) -> Type<'static> {
        let Ok(st) = SpirvType::try_from(t) else {
            return match t {
                Type::Function(f) => Type::Function(Box::new(FunctionType { inputs: f.inputs.iter().map(|x| self.expand(x, open)).collect(), results: f.results.iter().map(|x| self.expand(x, open)).collect() })),
                Type::Shaped(s) => {
                    let mut s = s.clone();
                    s.elem = Box::new(self.expand(&s.elem, open));
                    Type::Shaped(s)
                }
                t => t.clone(),
            };
        };
        let inner = |r: &Self, x: &Type<'static>, open: &mut Vec<String>| Box::new(r.expand(x, open));
        match st {
            SpirvType::Struct { name: Some(n), members, decorations } => {
                if open.contains(&n) {
                    return SpirvType::Struct { name: Some(n), members: None, decorations: Vec::new() }.into();
                }
                let (members, decorations) = match (members, self.identified.get(&n).and_then(|b| SpirvType::try_from(b).ok())) {
                    (None, Some(SpirvType::Struct { members, decorations, .. })) => (members, decorations),
                    (m, _) => (m, decorations),
                };
                open.push(n.clone());
                let members = members.map(|ms| ms.into_iter().map(|m| SpirvMember { ty: self.expand(&m.ty, open), ..m }).collect());
                open.pop();
                SpirvType::Struct { name: Some(n), members, decorations }.into()
            }
            SpirvType::Struct { name: None, members, decorations } => SpirvType::Struct { name: None, members: members.map(|ms| ms.into_iter().map(|m| SpirvMember { ty: self.expand(&m.ty, open), ..m }).collect()), decorations }.into(),
            SpirvType::Ptr { pointee, storage } => SpirvType::Ptr { pointee: inner(self, &pointee, open), storage }.into(),
            SpirvType::Array { len, elem, stride } => SpirvType::Array { len, elem: inner(self, &elem, open), stride }.into(),
            SpirvType::RuntimeArray { elem, stride } => SpirvType::RuntimeArray { elem: inner(self, &elem, open), stride }.into(),
            SpirvType::Matrix { cols, column } => SpirvType::Matrix { cols, column: inner(self, &column, open) }.into(),
            SpirvType::SampledImage(i) => SpirvType::SampledImage(inner(self, &i, open)).into(),
            other => other.into(),
        }
    }

    /// Spells out identified structs everywhere a type appears
    fn expand_all(&mut self) {
        if self.identified.is_empty() {
            return;
        }
        for i in 0..self.tree.types.len() {
            let t = self.tree.types[i].clone();
            self.tree.types[i] = self.expand(&t, &mut Vec::new());
        }
        for i in 0..self.tree.nodes.len() {
            let attrs = core::mem::take(&mut self.tree.nodes[i].attrs);
            self.tree.nodes[i].attrs = attrs.into_iter().map(|(n, a)| match a {
                Attribute::Type(t) => (n, Attribute::Type(self.expand(&t, &mut Vec::new()))),
                a => (n, a),
            }).collect();
        }
    }

    fn camel(snake: &str) -> String {
        let mut out = String::new();
        let mut up = true;
        for ch in snake.chars() {
            if ch == '_' {
                up = true;
            } else if up {
                out.extend(ch.to_uppercase());
                up = false;
            } else {
                out.push(ch);
            }
        }
        let spec = EnumSpec::of(Reader::DECORATION);
        spec.and_then(|s| s.cases.iter().find(|c| c.name.eq_ignore_ascii_case(&out))).map_or(out, |c| String::from(c.name))
    }

    fn resolve_structs(&mut self, ptr: u32, t: &Type<'static>) -> Result<(), Error> {
        let mut done = Vec::new();
        for (k, p) in self.pending_structs.iter_mut().enumerate() {
            p.unresolved.retain(|(id, i)| {
                if *id == ptr {
                    p.members[*i] = Some(t.clone());
                    false
                } else {
                    true
                }
            });
            if p.unresolved.is_empty() {
                done.push(k);
            }
        }
        for k in done.into_iter().rev() {
            let p = self.pending_structs.remove(k);
            let body = self.struct_body(p.id, p.members.into_iter().map(|m| m.expect("resolved")).collect());
            if let Some(n) = self.names.get(&p.id) {
                self.identified.insert(n.clone(), body.clone());
            }
            self.types.insert(p.id, body);
        }
        Ok(())
    }

    // ----- constants -----------------------------------------------------------------------

    fn constant(&mut self, w: &[u32], spec: bool) -> Result<(), Error> {
        let ty = self.get_type(w[0])?;
        let wide = || u64::from(w[2]) | w.get(3).map_or(0, |h| u64::from(*h) << 32);
        let scalar = match &ty {
            Type::Integer { width, .. } => {
                let bits = if *width == Reader::LONG_WORD { wide() } else { u64::from(w[2]) };
                Scalar::Int(ApInt::from_bits(*width, u128::from(bits)))
            }
            Type::Float(k) => {
                let bits = if *k == FloatKind::F64 { wide() } else { u64::from(w[2]) };
                Scalar::Float(ApFloat::from_bits(*k, bits).ok_or_else(|| Error(format!("bad {k:?} constant")))?)
            }
            t => return Reader::err(format!("OpConstant can only generate values of scalar integer or floating-point type, not {t}")),
        };
        let attr: Attribute<'static> = Const::scalar(scalar, ty.clone()).into();
        self.literals.insert(w[1], vec![Reader::literal(&attr)]);
        if spec {
            self.spec_constant(w[1], attr, ty);
        } else {
            self.constants.insert(w[1], (attr, ty));
        }
        Ok(())
    }

    fn spec_constant(&mut self, id: u32, value: Attribute<'static>, ty: Type<'static>) {
        let name = self.names.get(&id).cloned().unwrap_or_else(|| format!("spirv_spec_const_{id}"));
        let mut attrs = vec![(String::from("sym_name"), Attribute::str(&name)), (String::from("default_value"), value)];
        attrs.extend(self.decorations.get(&id).cloned().unwrap_or_default());
        self.module_op("spirv.SpecConstant", attrs, 0);
        self.specs.insert(id, (name, ty));
    }

    /// An op at the end of the module's block, wherever the reader is
    fn module_op(&mut self, name: &str, attrs: Vec<(String, Attribute<'static>)>, regions: usize) -> O {
        let saved = self.tree.at.replace(At::End(self.module_block));
        let o = self.tree.create(name, &[], &[], attrs, &[], regions);
        self.tree.at = saved;
        o
    }

    fn constant_composite(&mut self, w: &[u32]) -> Result<(), Error> {
        let ty = self.get_type(w[0])?;
        let parts = w[2..].iter().map(|c| self.constants.get(c).map(|(a, _)| a.clone()).ok_or_else(|| Error(format!("OpConstantComposite component <id> {c} must come from a normal constant")))).collect::<Result<Vec<_>, _>>()?;
        let attr = match &ty {
            Type::Extended(_) if matches!(SpirvType::try_from(&ty), Ok(SpirvType::TensorArm { .. })) => {
                let Ok(SpirvType::TensorArm { shape, .. }) = SpirvType::try_from(&ty) else { unreachable!("matched above") };
                let lits: Vec<String> = w[2..].iter().flat_map(|c| self.literals.get(c).cloned().unwrap_or_default()).collect();
                self.literals.insert(w[1], lits.clone());
                Attribute::Builtin { name: "dense".into(), body: Reader::dense(shape.as_deref().unwrap_or(&[]), &lits).into(), ty: Some(ty.clone()) }
            }
            Type::Extended(_) if matches!(SpirvType::try_from(&ty), Ok(SpirvType::CoopMatrix { .. })) => {
                let lit = match parts.first() {
                    Some(Attribute::Int { lit, .. } | Attribute::Float { lit, .. }) => String::from(&**lit),
                    Some(Attribute::Bool(b)) => format!("{b}"),
                    _ => return Reader::err("a composite of non-scalars"),
                };
                if parts.iter().any(|p| *p != parts[0]) {
                    return Reader::err("a cooperative matrix constant that is not a splat");
                }
                Attribute::Builtin { name: "dense".into(), body: format!("<{lit}>").into(), ty: Some(ty.clone()) }
            }
            Type::Shaped(_) => {
                let mut values = Vec::new();
                for p in &parts {
                    let c = Const::try_from(p).map_err(|_| Error::from("a composite of non-scalars"))?;
                    let n = if c.elements { c.ty.element_count().unwrap_or(1) } else { 1 };
                    values.extend((0..n).map(|i| c.at(i)));
                }
                Const { ty: ty.clone(), values, elements: true }.into()
            }
            _ => {
                let lits: Vec<String> = w[2..].iter().flat_map(|c| self.literals.get(c).cloned().unwrap_or_default()).collect();
                self.literals.insert(w[1], lits);
                Attribute::Array(parts.into_iter().map(Reader::elided).collect())
            }
        };
        self.constants.insert(w[1], (attr, ty));
        Ok(())
    }

    /// A scalar attribute's literal (`1.000000e+00`, `-3`, `true`)
    fn literal(a: &Attribute<'_>) -> String {
        match a {
            Attribute::Int { lit, .. } | Attribute::Float { lit, .. } => String::from(&**lit),
            Attribute::Bool(b) => format!("{b}"),
            other => format!("{other}"),
        }
    }

    /// `<...>` of a dense attribute of `shape` holding `lits` row-major: one literal when they are
    /// all the same (a splat), nested brackets otherwise
    fn dense(shape: &[i64], lits: &[String]) -> String {
        if lits.iter().all(|l| *l == lits[0]) && !lits.is_empty() {
            return format!("<{}>", lits[0]);
        }
        let mut out = String::from("<");
        Reader::nest(shape, lits, &mut 0, &mut out);
        out.push('>');
        out
    }

    fn nest(shape: &[i64], lits: &[String], at: &mut usize, out: &mut String) {
        let Some((n, rest)) = shape.split_first() else {
            out.push_str(&lits[*at]);
            *at += 1;
            return;
        };
        out.push('[');
        for i in 0..*n {
            if i > 0 {
                out.push_str(", ");
            }
            Reader::nest(rest, lits, at, out);
        }
        out.push(']');
    }

    fn int_constant(&self, id: u32) -> Result<i64, Error> {
        self.constants.get(&id).and_then(|(a, _)| Const::try_from(a).ok()?.as_int()).map(|v| v.signed() as i64).ok_or_else(|| Error(format!("<id> {id} is not an integer constant")))
    }

    /// An array's element as MLIR prints it: without its type when that is the default (`i64`,
    /// `f64`)
    fn elided(a: Attribute<'static>) -> Attribute<'static> {
        match a {
            Attribute::Int { lit, ty: Some(Type::Integer { signedness: Signedness::Signless, width: Reader::LONG_WORD }) } => Attribute::Int { lit, ty: None },
            Attribute::Float { lit, ty: Some(Type::Float(FloatKind::F64)) } => Attribute::Float { lit, ty: None },
            Attribute::Array(xs) => Attribute::Array(xs.into_iter().map(Reader::elided).collect()),
            a => a,
        }
    }

    fn constant_null(&mut self, w: &[u32]) -> Result<(), Error> {
        let ty = self.get_type(w[0])?;
        let zero = |t: &Type<'_>| match t {
            Type::Integer { width, .. } => Some(Scalar::Int(ApInt::new(*width, 0))),
            Type::Float(k) => ApFloat::from_bits(*k, 0).map(Scalar::Float),
            _ => None,
        };
        let attr: Attribute<'static> = match &ty {
            Type::Extended(_) => {
                let Ok(SpirvType::TensorArm { elem, .. }) = SpirvType::try_from(&ty) else { return Reader::err(format!("unsupported OpConstantNull type: {ty}")) };
                let z: Attribute<'static> = match &*elem {
                    Type::Integer { width: 1, .. } => Attribute::Bool(false),
                    t => Const::scalar(zero(t).ok_or_else(|| Error::from("unsupported OpConstantNull type"))?, t.clone()).into(),
                };
                Attribute::Builtin { name: "dense".into(), body: format!("<{}>", Reader::literal(&z)).into(), ty: Some(ty.clone()) }
            }
            Type::Integer { width: 1, .. } => Attribute::Bool(false),
            Type::Shaped(s) => Const::splat(zero(&s.elem).ok_or_else(|| Error::from("unsupported OpConstantNull type"))?, ty.clone()).into(),
            t => Const::scalar(zero(t).ok_or_else(|| Error(format!("unsupported OpConstantNull type: {t}")))?, ty.clone()).into(),
        };
        self.constants.insert(w[1], (attr, ty));
        Ok(())
    }

    fn spec_composite(&mut self, w: &[u32]) -> Result<(), Error> {
        let ty = self.get_type(w[0])?;
        let name = self.names.get(&w[1]).cloned().unwrap_or_else(|| format!("spirv_spec_const_{}", w[1]));
        let parts = w[2..].iter().map(|c| self.specs.get(c).map(|(n, _)| Attribute::SymbolRef(vec![n.clone().into()])).ok_or_else(|| Error(format!("spec constant {c} not defined")))).collect::<Result<Vec<_>, _>>()?;
        self.module_op("spirv.SpecConstantComposite", vec![(String::from("type"), Attribute::Type(ty.clone())), (String::from("sym_name"), Attribute::str(&name)), (String::from("constituents"), Attribute::Array(parts))], 0);
        self.specs.insert(w[1], (name, ty));
        Ok(())
    }

    fn spec_replicate(&mut self, w: &[u32]) -> Result<(), Error> {
        let ty = self.get_type(w[0])?;
        let name = self.names.get(&w[1]).cloned().unwrap_or_else(|| format!("spirv_spec_const_{}", w[1]));
        let part = self.specs.get(&w[2]).map(|(n, _)| n.clone()).ok_or_else(|| Error::from("OpSpecConstantCompositeReplicateEXT of an unknown spec constant"))?;
        self.module_op("spirv.EXT.SpecConstantCompositeReplicate", vec![(String::from("type"), Attribute::Type(ty.clone())), (String::from("sym_name"), Attribute::str(&name)), (String::from("constituent"), Attribute::SymbolRef(vec![part.into()]))], 0);
        self.specs.insert(w[1], (name, ty));
        Ok(())
    }

    // ----- decorations ---------------------------------------------------------------------

    fn decorate(&mut self, id: u32, name: &str, value: Attribute<'static>) {
        let list = self.decorations.entry(id).or_default();
        match list.iter_mut().find(|(n, _)| n == name) {
            Some(x) => x.1 = value,
            None => {
                let at = list.iter().position(|(n, _)| n.as_str() > name).unwrap_or(list.len());
                list.insert(at, (String::from(name), value));
            }
        }
    }

    fn decoration(&mut self, w: &[u32]) -> Result<(), Error> {
        let (id, d) = (w[0], w[1]);
        let name = Deco::name(d).ok_or_else(|| Error(format!("invalid Decoration code : {d}")))?;
        let symbol = Reader::snake(name);
        match d {
            Deco::FP_FAST_MATH_MODE => self.decorate(id, &symbol, Reader::enum_attr("FPFastMathMode", w[2])?),
            Deco::FP_ROUNDING_MODE => self.decorate(id, &symbol, Reader::enum_attr("FPRoundingMode", w[2])?),
            Deco::BUILT_IN => {
                let b = EnumSpec::of("BuiltIn").and_then(|s| s.text(w[2])).ok_or_else(|| Error(format!("unknown BuiltIn {}", w[2])))?;
                self.decorate(id, &symbol, Attribute::str(&b));
            }
            Deco::ARRAY_STRIDE => {
                self.strides.insert(id, w[2]);
            }
            Deco::LINKAGE_ATTRIBUTES => {
                let mut at = 2;
                let lname = Reader::string(w, &mut at);
                let kind = EnumSpec::of("LinkageType").and_then(|s| s.text(*w.get(at)?)).ok_or_else(|| Error::from("bad linkage type"))?;
                self.decorate(id, &symbol, Attribute::dialect_with("spirv.linkage_attributes", format!("linkage_name = \"{lname}\", linkage_type = <{kind}>")));
            }
            Deco::CACHE_CONTROL_LOAD_INTEL | Deco::CACHE_CONTROL_STORE_INTEL => {
                let (attr, class) = if d == Deco::CACHE_CONTROL_LOAD_INTEL { ("spirv.cache_control_load_intel", "LoadCacheControl") } else { ("spirv.cache_control_store_intel", "StoreCacheControl") };
                let kind = EnumSpec::of(class).and_then(|s| s.text(w[3])).ok_or_else(|| Error::from("bad cache control"))?;
                let value = Attribute::dialect_with(attr, format!("cache_level = {}, {} = {kind}", w[2], Reader::snake(class)));
                let mut list = match self.decorations.get(&id).and_then(|l| l.iter().find(|(n, _)| *n == symbol)) {
                    Some((_, Attribute::Array(a))) => a.clone(),
                    _ => Vec::new(),
                };
                list.push(value);
                self.decorate(id, &symbol, Attribute::Array(list));
            }
            Deco::ALIGNMENT_ID | Deco::MAX_BYTE_OFFSET_ID | Deco::COUNTER_BUFFER => self.id_decorations.push((id, d, w[2])),
            d if Deco::UNIT.contains(&d) => self.decorate(id, &symbol, Attribute::Unit),
            d if Deco::INTEGER.contains(&d) => self.decorate(id, &symbol, Attribute::i32(i64::from(w[2] as i32))),
            _ => return Reader::err(format!("unhandled Decoration : '{name}")),
        }
        Ok(())
    }

    fn resolve_id_decorations(&mut self) -> Result<(), Error> {
        for (target, d, operand) in core::mem::take(&mut self.id_decorations) {
            let symbol = Reader::snake(Deco::name(d).unwrap_or_default());
            let sym = self.globals.get(&operand).map(|(n, _)| n.clone()).or_else(|| self.specs.get(&operand).map(|(n, _)| n.clone())).ok_or_else(|| Error(format!("<id> {operand} is not a global variable or specialization constant")))?;
            let name = self.globals.get(&target).map(|(n, _)| n.clone()).or_else(|| self.specs.get(&target).map(|(n, _)| n.clone())).or_else(|| self.funcs.get(&target).map(|(_, n)| n.clone()));
            let mut all = Vec::new();
            self.tree.walk(self.module, &mut all);
            let op = match name {
                Some(n) => all.into_iter().find(|o| matches!(self.tree.node(*o).get("sym_name"), Some(Attribute::Str { lit, .. }) if **lit == *n)),
                None => self.values.get(&target).and_then(|v| all.into_iter().find(|o| self.tree.node(*o).results.contains(v))),
            };
            let op = op.ok_or_else(|| Error(format!("unknown target <id> {target}")))?;
            self.tree.node_mut(op).set(&symbol, Attribute::SymbolRef(vec![sym.into()]));
        }
        Ok(())
    }

    // ----- module-level ops ----------------------------------------------------------------

    fn global_variable(&mut self, w: &[u32]) -> Result<(), Error> {
        let ty = self.get_type(w[0])?;
        let id = w[1];
        let name = self.names.get(&id).cloned().unwrap_or_else(|| format!("spirv_var_{id}"));
        let mut attrs = vec![(String::from("type"), Attribute::Type(ty.clone())), (String::from("sym_name"), Attribute::str(&name))];
        if let Some(init) = w.get(3) {
            let sym = self.globals.get(init).map(|(n, _)| n.clone()).or_else(|| self.specs.get(init).map(|(n, _)| n.clone())).ok_or_else(|| Error(format!("unknown <id> {init} used as initializer")))?;
            attrs.push((String::from("initializer"), Attribute::SymbolRef(vec![sym.into()])));
        }
        attrs.extend(self.decorations.get(&id).cloned().unwrap_or_default());
        self.module_op("spirv.GlobalVariable", attrs, 0);
        self.globals.insert(id, (name, ty));
        Ok(())
    }

    fn function_symbol(&self, id: u32) -> String {
        self.names.get(&id).cloned().unwrap_or_else(|| format!("spirv_fn_{id}"))
    }

    fn entry_point(&mut self, w: &[u32]) -> Result<(), Error> {
        let model = Reader::enum_attr("ExecutionModel", w[0])?;
        let mut at = 2;
        let name = Reader::string(w, &mut at);
        let (f, fname) = self.funcs.get(&w[1]).cloned().ok_or_else(|| Error(format!("no function matching <id> {}", w[1])))?;
        if fname != name {
            if !fname.starts_with("spirv_fn_") {
                return Reader::err(format!("function name mismatch between OpEntryPoint and OpFunction with <id> {}: {name} vs. {fname}", w[1]));
            }
            self.tree.node_mut(f).set("sym_name", Attribute::str(&name));
            self.funcs.insert(w[1], (f, name.clone()));
        }
        let interface = w[at..].iter().map(|g| self.globals.get(g).map(|(n, _)| Attribute::SymbolRef(vec![n.clone().into()])).ok_or_else(|| Error(format!("undefined result <id> {g} while decoding OpEntryPoint")))).collect::<Result<Vec<_>, _>>()?;
        self.module_op("spirv.EntryPoint", vec![(String::from("execution_model"), model), (String::from("fn"), Attribute::SymbolRef(vec![name.into()])), (String::from("interface"), Attribute::Array(interface))], 0);
        Ok(())
    }

    fn execution_mode(&mut self, w: &[u32], ids: bool) -> Result<(), Error> {
        let (_, fname) = self.funcs.get(&w[0]).cloned().ok_or_else(|| Error(format!("no function matching <id> {}", w[0])))?;
        let mode = Reader::enum_attr("ExecutionMode", w[1])?;
        let values = w[2..].iter().map(|v| if ids { Attribute::SymbolRef(vec![self.specs.get(v).map_or_else(|| format!("spirv_spec_const_{v}"), |(n, _)| n.clone()).into()]) } else { Attribute::i32(i64::from(*v as i32)) }).collect();
        let name = if ids { "spirv.ExecutionModeId" } else { "spirv.ExecutionMode" };
        self.module_op(name, vec![(String::from("fn"), Attribute::SymbolRef(vec![fname.into()])), (String::from("execution_mode"), mode), (String::from("values"), Attribute::Array(values))], 0);
        Ok(())
    }

    // ----- functions -----------------------------------------------------------------------

    fn function(&mut self, w: &[u32]) -> Result<(), Error> {
        if self.func.is_some() {
            return Reader::err("found function inside function");
        }
        let fn_id = w[1];
        let Some(Type::Function(fty)) = self.types.get(&w[3]).cloned() else { return Reader::err(format!("unknown function type from <id> {}", w[3])) };
        let name = self.function_symbol(fn_id);
        let control = Reader::enum_attr("FunctionControl", w[2])?;
        let mut attrs = vec![(String::from("sym_name"), Attribute::str(&name)), (String::from("function_type"), Attribute::Type(Type::Function(fty.clone()))), (String::from("function_control"), control)];
        attrs.extend(self.decorations.get(&fn_id).cloned().unwrap_or_default());
        let f = self.module_op("spirv.func", attrs, 1);
        self.funcs.insert(fn_id, (f, name));
        let r = self.tree.node(f).regions[0];
        let entry = self.tree.block_in(r);
        let mut arg_attrs = Vec::new();
        for t in &fty.inputs {
            let (op, p) = self.slice()?;
            if op != Opcode::FUNCTION_PARAMETER {
                return Reader::err("missing OpFunctionParameter instruction");
            }
            let a = self.tree.arg(entry, t.clone());
            self.values.insert(p[1], a);
            arg_attrs.push(self.arg_attr(p[1])?);
        }
        if arg_attrs.iter().any(|a| !matches!(a, Attribute::Dict(d) if d.is_empty())) {
            self.tree.node_mut(f).set("arg_attrs", Attribute::Array(arg_attrs));
        }
        let import = self.decorations.get(&fn_id).is_some_and(|ds| ds.iter().any(|(_, a)| matches!(a, Attribute::Extended { ext, .. } if ext.inner().is_some_and(|b| b.ends_with("<Import>")))));
        if import {
            self.tree.reg_mut(r).blocks.clear();
        }
        self.func = Some(f);
        let (op, l) = self.slice()?;
        if op == Opcode::FUNCTION_END {
            return self.function_end();
        }
        if op != Opcode::LABEL {
            return Reader::err("a basic block must start with OpLabel");
        }
        self.block_ids.insert(l[0], entry);
        self.tree.start(entry);
        self.block = Some(entry);
        loop {
            let (op, w) = self.slice()?;
            if op == Opcode::FUNCTION_END {
                break;
            }
            self.instruction(op, &w, true)?;
        }
        self.function_end()
    }

    fn graph(&mut self, w: &[u32]) -> Result<(), Error> {
        if self.func.is_some() {
            return Reader::err("found graph inside graph");
        }
        let Some(Type::Function(fty)) = self.types.get(&w[0]).cloned() else { return Reader::err(format!("unknown graph type from <id> {}", w[0])) };
        let id = w[1];
        let name = self.names.get(&id).cloned().unwrap_or_else(|| format!("spirv_graph_{id}"));
        let attrs = vec![(String::from("sym_name"), Attribute::str(&name)), (String::from("function_type"), Attribute::Type(Type::Function(fty.clone()))), (String::from("entry_point"), Attribute::Bool(false))];
        let g = self.module_op("spirv.ARM.Graph", attrs, 1);
        self.graphs.insert(id, g);
        let r = self.tree.node(g).regions[0];
        let entry = self.tree.block_in(r);
        let args: Vec<V> = fty.inputs.iter().map(|t| self.tree.arg(entry, t.clone())).collect();
        for _ in &fty.inputs {
            let (op, p) = self.slice()?;
            if op != Opcode::GRAPH_INPUT_ARM {
                return Reader::err("expected OpGraphInputARM");
            }
            let i = self.int_constant(p[2])? as usize;
            self.values.insert(p[1], *args.get(i).ok_or_else(|| Error::from("a graph input index out of range"))?);
        }
        self.outputs = vec![None; fty.results.len()];
        self.func = Some(g);
        self.block_ids.insert(id, entry);
        self.tree.start(entry);
        self.block = Some(entry);
        loop {
            let (op, w) = self.slice()?;
            self.instruction(op, &w, true)?;
            if op == Opcode::GRAPH_END_ARM {
                return Ok(());
            }
        }
    }

    fn graph_entry_point(&mut self, w: &[u32]) -> Result<(), Error> {
        let g = *self.graphs.get(&w[0]).ok_or_else(|| Error(format!("missing graph definition/declaration with id {}", w[0])))?;
        let mut at = 1;
        let name = Reader::string(w, &mut at);
        self.tree.node_mut(g).set("sym_name", Attribute::str(&name));
        self.tree.node_mut(g).set("entry_point", Attribute::Bool(true));
        let interface = w[at..].iter().map(|v| self.globals.get(v).map(|(n, _)| Attribute::SymbolRef(vec![n.clone().into()])).ok_or_else(|| Error(format!("undefined result <id> {v} while decoding OpGraphEntryPoint")))).collect::<Result<Vec<_>, _>>()?;
        let saved = self.tree.at.replace(At::Before(g));
        self.tree.create("spirv.ARM.GraphEntryPoint", &[], &[], vec![(String::from("fn"), Attribute::SymbolRef(vec![name.into()])), (String::from("interface"), Attribute::Array(interface))], &[], 0);
        self.tree.at = saved;
        Ok(())
    }

    fn arg_attr(&self, id: u32) -> Result<Attribute<'static>, Error> {
        let Some(ds) = self.decorations.get(&id) else { return Ok(Attribute::Dict(Vec::new())) };
        let mut found = None;
        for (n, _) in ds {
            let hit = Deco::ARGUMENT.iter().chain([&Deco::RELAXED_PRECISION]).find(|d| Deco::name(**d).is_some_and(|x| Reader::snake(x) == *n));
            if let Some(d) = hit {
                if found.is_some() {
                    return Reader::err(format!("more than one decoration for function argument with result <id> {id}"));
                }
                found = Some(*d);
            }
        }
        let d = found.ok_or_else(|| Error(format!("unimplemented decoration support for function argument with result <id> {id}")))?;
        Ok(Attribute::Dict(vec![mlirformat::NamedAttr { name: "spirv.decoration".into(), value: Some(Reader::enum_attr(Reader::DECORATION, d)?) }]))
    }

    fn function_end(&mut self) -> Result<(), Error> {
        self.wire_phis()?;
        if self.structurize {
            self.structurize()?;
        }
        self.merges.clear();
        self.func = None;
        self.block = None;
        self.block_ids.clear();
        self.tree.at = Some(At::End(self.module_block));
        Ok(())
    }

    fn get_block(&mut self, id: u32) -> B {
        if let Some(b) = self.block_ids.get(&id) {
            return *b;
        }
        let f = self.func.expect("a block inside a function");
        let r = self.tree.node(f).regions[0];
        let b = self.tree.block_in(r);
        self.block_ids.insert(id, b);
        b
    }

    // ----- values --------------------------------------------------------------------------

    /// The value of `id`, materializing a constant, a variable's address or a spec constant's
    /// reference at the insertion point, as MLIR's `Deserializer::getValue`
    fn value(&mut self, id: u32) -> Result<V, Error> {
        let one = |r: &mut Self, name: &str, attrs: Vec<(String, Attribute<'static>)>, ty: Type<'static>| {
            let o = r.tree.create(name, &[], &[ty], attrs, &[], 0);
            r.tree.node(o).results[0]
        };
        if let Some((a, t)) = self.constants.get(&id).cloned() {
            return Ok(one(self, "spirv.Constant", vec![(String::from("value"), a)], t));
        }
        if let Some((a, t)) = self.replicates.get(&id).cloned() {
            return Ok(one(self, "spirv.EXT.ConstantCompositeReplicate", vec![(String::from("value"), a)], t));
        }
        if let Some((n, t)) = self.globals.get(&id).cloned() {
            return Ok(one(self, "spirv.mlir.addressof", vec![(String::from("variable"), Attribute::SymbolRef(vec![n.into()]))], t));
        }
        if let Some((n, t)) = self.specs.get(&id).cloned() {
            return Ok(one(self, "spirv.mlir.referenceof", vec![(String::from("spec_const"), Attribute::SymbolRef(vec![n.into()]))], t));
        }
        if let Some((op, ty, operands)) = self.spec_ops.get(&id).cloned() {
            return self.spec_operation(op, ty, &operands);
        }
        if let Some(t) = self.undefs.get(&id).cloned() {
            return Ok(one(self, "spirv.Undef", Vec::new(), t));
        }
        if let Some((t, n)) = self.graph_constants.get(&id).cloned() {
            return Ok(one(self, "spirv.ARM.GraphConstant", vec![(String::from("graph_constant_id"), Attribute::i32(n))], t));
        }
        self.values.get(&id).copied().ok_or_else(|| Error(format!("unknown result <id>: {id}")))
    }

    fn spec_operation(&mut self, op: u32, ty: u32, operands: &[u32]) -> Result<V, Error> {
        const FAKE: u32 = u32::MAX - 2;
        let saved = core::mem::take(&mut self.values);
        let mut words = vec![ty, FAKE];
        words.extend_from_slice(operands);
        let result = self.instruction(op, &words, false);
        let inner = self.values.get(&FAKE).copied();
        self.values = saved;
        result?;
        let inner = inner.ok_or_else(|| Error::from("OpSpecConstantOp made no value"))?;
        let enclosed = self.tree.blk(self.block.expect("a block")).ops.last().copied().expect("the enclosed op");
        self.tree.unlink(enclosed);
        let t = self.get_type(ty)?;
        let o = self.tree.create("spirv.SpecConstantOperation", &[], &[t], Vec::new(), &[], 1);
        let r = self.tree.node(o).regions[0];
        let b = self.tree.block_in(r);
        self.tree.insert(enclosed, At::End(b));
        let saved_at = self.tree.at.replace(At::End(b));
        self.tree.create("spirv.mlir.yield", &[inner], &[], Vec::new(), &[], 0);
        self.tree.at = saved_at;
        Ok(self.tree.node(o).results[0])
    }

    // ----- control flow --------------------------------------------------------------------

    fn branch_conditional(&mut self, w: &[u32]) -> Result<(), Error> {
        let c = self.value(w[0])?;
        let (t, f) = (self.get_block(w[1]), self.get_block(w[2]));
        let mut attrs = vec![(String::from(Reader::SEGMENTS), Attribute::dense_array(32, &[1, 0, 0]))];
        if w.len() == 5 {
            attrs.push((String::from("branch_weights"), Attribute::Array(vec![Attribute::i32(i64::from(w[3])), Attribute::i32(i64::from(w[4]))])));
        }
        self.tree.create("spirv.BranchConditional", &[c], &[], attrs, &[t, f], 0);
        Ok(())
    }

    fn switch(&mut self, w: &[u32]) -> Result<(), Error> {
        let selector = self.value(w[0])?;
        let default = self.get_block(w[1]);
        let mut literals = Vec::new();
        let mut targets = vec![default];
        for pair in w[2..].chunks(2) {
            literals.push(pair[0] as i32);
            targets.push(self.get_block(pair[1]));
        }
        let sel_ty = self.tree.ty(selector).clone();
        let lits: Attribute<'static> = Const { ty: Type::vector(&[literals.len() as i64], &[], sel_ty.clone()), values: literals.iter().map(|l| Scalar::Int(ApInt::new(match sel_ty { Type::Integer { width, .. } => width, _ => Reader::WORD_BITS }, i128::from(*l)))).collect(), elements: true }.into();
        let mut attrs = vec![(String::from(Reader::SEGMENTS), Attribute::dense_array(32, &[1, 0, 0])), (String::from(Reader::CASE_SEGMENTS), Attribute::dense_array(32, &vec![0; literals.len()]))];
        if !literals.is_empty() {
            attrs.push((String::from("literals"), lits));
        }
        self.tree.create("spirv.Switch", &[selector], &[], attrs, &targets, 0);
        Ok(())
    }

    fn phi(&mut self, w: &[u32]) -> Result<(), Error> {
        let b = self.block.ok_or_else(|| Error::from("OpPhi must appear in a block"))?;
        let t = self.get_type(w[0])?;
        let a = self.tree.arg(b, t);
        self.values.insert(w[1], a);
        for pair in w[2..].chunks(2) {
            let pred = self.get_block(pair[1]);
            match self.phis.iter_mut().find(|(k, _)| *k == (pred, b)) {
                Some((_, v)) => v.push(pair[0]),
                None => self.phis.push(((pred, b), vec![pair[0]])),
            }
        }
        Ok(())
    }

    // ----- grammar ops ---------------------------------------------------------------------

    fn ext_inst(&mut self, w: &[u32]) -> Result<(), Error> {
        let set = self.ext_sets.get(&w[2]).cloned().ok_or_else(|| Error::from("undefined set <id> in OpExtInst"))?;
        let spec = OpSpec::ext(&set, w[3]).ok_or_else(|| Error(format!("unknown {set} instruction {}", w[3])))?;
        let mut words = vec![w[0], w[1]];
        words.extend_from_slice(&w[4..]);
        self.grammar(spec, &words)
    }

    fn autogen(&mut self, op: u32, w: &[u32]) -> Result<(), Error> {
        match op {
            Opcode::FUNCTION_CALL => return self.function_call(w),
            Opcode::COPY_MEMORY => return self.copy_memory(w),
            Opcode::GENERIC_CAST_TO_PTR_EXPLICIT => {
                let t = self.get_type(w[0])?;
                let v = self.value(w[2])?;
                let o = self.tree.create("spirv.GenericCastToPtrExplicit", &[v], &[t], Vec::new(), &[], 0);
                self.values.insert(w[1], self.tree.node(o).results[0]);
                return Ok(());
            }
            _ => {}
        }
        let spec = OpSpec::code(op).ok_or_else(|| Error(format!("unhandled opcode {op}")))?;
        self.grammar(spec, w)
    }

    /// An op its ODS grammar describes: result type and <id>, then operands and attributes in
    /// the order of its arguments, as `mlir-tblgen`'s `processOp<...>`
    fn grammar(&mut self, spec: &OpSpec<'_>, w: &[u32]) -> Result<(), Error> {
        let mut at = 0;
        let mut types = Vec::new();
        let mut id = None;
        if spec.results == 1 {
            types.push(self.get_type(*w.first().ok_or_else(|| Error(format!("expected result type <id> while deserializing {}", spec.name)))?)?);
            id = Some(*w.get(1).ok_or_else(|| Error(format!("expected result <id> while deserializing {}", spec.name)))?);
            at = 2;
        }
        let mut operands = Vec::new();
        let mut attrs: Vec<(String, Attribute<'static>)> = Vec::new();
        if spec.plain {
            for _ in spec.groups {
                let x = *w.get(at).ok_or_else(|| Error(format!("found less operands than expected when deserializing for {}", spec.name)))?;
                operands.push(self.value(x)?);
                at += 1;
            }
        } else {
            for a in spec.args {
                match a {
                    Arg::Operands(g) => match spec.groups[*g as usize] {
                        Group::Variadic => {
                            while let Some(x) = w.get(at) {
                                operands.push(self.value(*x)?);
                                at += 1;
                            }
                        }
                        _ => {
                            if let Some(x) = w.get(at) {
                                operands.push(self.value(*x)?);
                                at += 1;
                            }
                        }
                    },
                    Arg::Attr(name, kind, class) => {
                        if at >= w.len() {
                            continue;
                        }
                        let value = match kind {
                            Some(AttrKind::Enum) => {
                                at += 1;
                                Reader::enum_attr(class.ok_or_else(|| Error::from("an enum without a class"))?, w[at - 1])?
                            }
                            Some(AttrKind::ConstId) => {
                                let c = self.constants.get(&w[at]).and_then(|(a, _)| Const::try_from(a).ok()?.as_int()).ok_or_else(|| Error(format!("{name}: not an integer constant")))?;
                                at += 1;
                                Reader::enum_attr(class.ok_or_else(|| Error::from("an enum without a class"))?, c.unsigned() as u32)?
                            }
                            Some(AttrKind::I32Array) => {
                                let xs = w[at..].iter().map(|v| Attribute::i32(i64::from(*v as i32))).collect();
                                at = w.len();
                                Attribute::Array(xs)
                            }
                            Some(AttrKind::I32) => {
                                at += 1;
                                Attribute::i32(i64::from(w[at - 1] as i32))
                            }
                            Some(AttrKind::Type) => {
                                at += 1;
                                Attribute::Type(self.get_type(w[at - 1])?)
                            }
                            None => {
                                let c = self.constants.get(&w[at]).map(|(a, _)| a.clone()).ok_or_else(|| Error(format!("could not fetch constant attribute for {name}")))?;
                                at += 1;
                                c
                            }
                        };
                        attrs.push((String::from(*name), value));
                    }
                }
            }
        }
        if at != w.len() {
            return Reader::err(format!("found more operands than expected when deserializing {}, only {at} of {} processed", spec.name, w.len()));
        }
        if let Some(id) = id {
            attrs.extend(self.decorations.get(&id).cloned().unwrap_or_default());
        }
        let o = self.tree.create(spec.name, &operands, &types, attrs, &[], 0);
        if let Some(id) = id {
            self.values.insert(id, self.tree.node(o).results[0]);
        }
        Ok(())
    }

    fn function_call(&mut self, w: &[u32]) -> Result<(), Error> {
        let void = self.voids.contains(&w[0]);
        let t = self.get_type(w[0])?;
        let name = self.function_symbol(w[2]);
        let args = w[3..].iter().map(|a| self.value(*a)).collect::<Result<Vec<_>, _>>()?;
        let types = if void { Vec::new() } else { vec![t] };
        let o = self.tree.create("spirv.FunctionCall", &args, &types, vec![(String::from("callee"), Attribute::SymbolRef(vec![name.into()]))], &[], 0);
        if !void {
            self.values.insert(w[1], self.tree.node(o).results[0]);
        }
        Ok(())
    }

    fn copy_memory(&mut self, w: &[u32]) -> Result<(), Error> {
        const ALIGNED: u32 = 2;
        let target = self.value(w[0])?;
        let source = self.value(w[1])?;
        let mut attrs = Vec::new();
        let mut at = 2;
        if let Some(m) = w.get(at) {
            attrs.push((String::from("memory_access"), Reader::enum_attr("MemoryAccess", *m)?));
            at += 1;
            if *m == ALIGNED
                && let Some(a) = w.get(at)
            {
                attrs.push((String::from("alignment"), Attribute::i32(i64::from(*a))));
                at += 1;
            }
        }
        if let Some(m) = w.get(at) {
            attrs.push((String::from("source_memory_access"), Reader::enum_attr("MemoryAccess", *m)?));
            at += 1;
        }
        if let Some(a) = w.get(at) {
            attrs.push((String::from("source_alignment"), Attribute::i32(i64::from(*a))));
        }
        self.tree.create("spirv.CopyMemory", &[target, source], &[], attrs, &[], 0);
        Ok(())
    }
}
