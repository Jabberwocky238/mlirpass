use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::{Attribute, Error, IntoStatic, MlirOpt, Operation, Type};

use crate::targets::tree::{At, B, O, R, Tree, V};

/// An op about to be made: its name, operands, attributes (inherent or not) and successors
pub struct OpData {
    pub name: String,
    pub operands: Vec<V>,
    pub attrs: Vec<(String, Attribute<'static>)>,
    pub successors: Vec<B>,
}

impl OpData {
    pub fn build(name: &str) -> Self {
        Self { name: String::from(name), operands: Vec::new(), attrs: Vec::new(), successors: Vec::new() }
    }

    pub fn operands(mut self, vs: &[V]) -> Self {
        self.operands = vs.to_vec();
        self
    }

    pub fn successors(mut self, bs: &[B]) -> Self {
        self.successors = bs.to_vec();
        self
    }

    pub fn segments(self, sizes: &[usize]) -> Self {
        let sizes: Vec<i64> = sizes.iter().map(|s| *s as i64).collect();
        self.with("operandSegmentSizes", Attribute::dense_array(32, &sizes))
    }

    pub fn with(mut self, name: &str, value: Attribute<'_>) -> Self {
        self.attrs.retain(|(k, _)| k != name);
        self.attrs.push((String::from(name), value.into_static()));
        self
    }

    /// A typed op's name and attributes (it has no operands, regions or successors yet)
    pub fn head<T>(op: &T) -> Result<Self, Error>
    where
        for<'o> Operation<'static>: TryFrom<&'o T, Error = Error>,
    {
        let g = Operation::try_from(op)?;
        let mut data = OpData::build(&g.name);
        if let Some(Attribute::Dict(props)) = g.properties {
            for a in props {
                data = data.with(&a.name, a.value.unwrap_or(Attribute::Unit));
            }
        }
        for a in g.attributes {
            data = data.with(&a.name, a.value.unwrap_or(Attribute::Unit));
        }
        Ok(data)
    }
}

/// The insertion point: a block, and the op the next one goes before (the end if none)
#[derive(Clone, Copy)]
pub struct Ip {
    pub block: B,
    pub before: Option<O>,
}

/// Builds ops into a `Tree` at an insertion point, giving each the default-valued attributes its
/// dialect declares and it was not given
pub struct Rw<'o> {
    pub body: Tree,
    pub ip: Option<Ip>,
    opt: &'o MlirOpt,
}

impl<'o> Rw<'o> {
    pub fn new(body: Tree, opt: &'o MlirOpt) -> Self {
        Self { body, ip: None, opt }
    }

    pub fn create(&mut self, data: OpData, types: &[Type<'_>]) -> O {
        self.create_with(data, types, |_, _| {})
    }

    /// An op at the insertion point, `f` giving it its regions and blocks first
    pub fn create_with(&mut self, mut data: OpData, types: &[Type<'_>], f: impl FnOnce(&mut Tree, O)) -> O {
        for a in self.opt.defaults(&data.name) {
            if !data.attrs.iter().any(|(k, _)| *k == *a.name) {
                data.attrs.push((String::from(&*a.name), a.value.unwrap_or(Attribute::Unit)));
            }
        }
        let types: Vec<Type<'static>> = types.iter().map(|t| t.clone().into_static()).collect();
        let saved = self.body.at.take();
        let o = self.body.create(&data.name, &data.operands, &types, data.attrs, &data.successors, 0);
        self.body.at = saved;
        f(&mut self.body, o);
        if let Some(ip) = self.ip {
            self.body.insert(o, ip.before.map_or(At::End(ip.block), At::Before));
        }
        o
    }

    pub fn set_end(&mut self, b: B) {
        self.ip = Some(Ip { block: b, before: None });
    }

    pub fn set_start(&mut self, b: B) {
        self.ip = Some(Ip { block: b, before: self.body.first(b) });
    }

    pub fn set_before(&mut self, o: O) {
        self.ip = Some(Ip { block: self.body.node(o).parent.expect("an op placed in a block"), before: Some(o) });
    }

    pub fn erase_op(&mut self, o: O) {
        self.body.unlink(o);
    }
}

impl Tree {
    pub fn add_region(&mut self, o: O) -> R {
        let r = self.new_region(o);
        self.node_mut(o).regions.push(r);
        r
    }

    pub fn add_block(&mut self, r: R, args: &[(Type<'_>, Option<()>)]) -> B {
        let b = self.block_in(r);
        for (t, _) in args {
            self.arg(b, t.clone().into_static());
        }
        b
    }

    /// The first block of `o`'s first region
    pub fn top_block(&self, o: O) -> B {
        self.reg(self.node(o).regions[0]).blocks[0]
    }

    pub fn last_op(&self, b: B) -> Option<O> {
        self.terminator(b)
    }
}
